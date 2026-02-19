/**
 * HealthMonitorService — background orchestrator for heart-rate and sleep
 * monitoring on the Huawei Watch Ultimate 2.
 *
 * This service has NO UI. It is started/stopped from EntryAbility and
 * controlled via toggles in SettingsPage.
 *
 * HR flow:
 *   1. sensor.on(HEART_RATE) at 10-min intervals → buffer BPM samples.
 *   2. Every 15 min push latest HR + resting HR to POST /api/health.
 *   3. Debounce: skip push if last push was < 14 min ago.
 *
 * Sleep flow (MVP):
 *   The server already ingests sleep data from Google Fit via Home Assistant.
 *   When sleep monitoring is enabled on the watch we simply continue pushing
 *   HR data during all hours (including sleep). The server-side bio_engine
 *   reconciles watch HR with Google Fit sleep data.
 *   If the watch detects 3 consecutive low-HR samples (< 60 BPM avg over
 *   30 min), it pushes a tentative sleep_duration on the next motion event.
 *   sleep_confidence is set to 0.5 to indicate "watch-estimated".
 */
import sensor from '@ohos.sensor';
import { Constants } from '../common/Constants';
import { StorageService } from './StorageService';
import { ServerService } from './ServerService';
import { HealthPushPayload } from '../model/WaterModel';
import hilog from '@ohos.hilog';

const TAG: string = 'HealthMonitorService';

export class HealthMonitorService {
  private static hrIntervalId: number = -1;
  private static hrBuffer: number[] = [];           // rolling BPM samples (keep last 3 = 30 min)
  private static hrSensorActive: boolean = false;
  private static sleepActive: boolean = false;
  private static lowHROnsetTime: number = 0;        // timestamp when low-HR streak started
  private static consecutiveLowHR: number = 0;      // count of consecutive low-HR samples

  /**
   * Called from EntryAbility.onCreate().
   * Starts HR + sleep monitoring if enabled in preferences.
   */
  public static async init(): Promise<void> {
    if (await StorageService.isHREnabled()) {
      HealthMonitorService.startHR();
    }
    if (await StorageService.isSleepEnabled()) {
      HealthMonitorService.startSleep();
    }
    hilog.info(0x0000, TAG, 'HealthMonitorService initialised');
  }

  // ─────────────────── Heart Rate ───────────────────

  /**
   * Start periodic HR sampling + server push.
   * Uses @ohos.sensor HEART_RATE sensor with 10-min interval (in nanoseconds).
   */
  public static startHR(): void {
    if (HealthMonitorService.hrSensorActive) {
      hilog.info(0x0000, TAG, 'HR sensor already active, skipping start');
      return;
    }

    try {
      sensor.on(sensor.SensorId.HEART_RATE, (data: sensor.HeartRateResponse) => {
        const bpm: number = data.heartRate;
        if (bpm > 0) {
          // Keep last 3 samples (≈ 30 min at 10-min intervals)
          HealthMonitorService.hrBuffer.push(bpm);
          if (HealthMonitorService.hrBuffer.length > 3) {
            HealthMonitorService.hrBuffer.shift();
          }
          hilog.info(0x0000, TAG, 'HR sample: %{public}d BPM (buffer size: %{public}d)',
            bpm, HealthMonitorService.hrBuffer.length);

          // Track consecutive low-HR for sleep detection
          if (bpm < 60) {
            HealthMonitorService.consecutiveLowHR++;
            if (HealthMonitorService.consecutiveLowHR === 1) {
              HealthMonitorService.lowHROnsetTime = Date.now();
            }
          } else {
            // If we were in a low-HR streak and HR goes back up, check for sleep push
            if (HealthMonitorService.consecutiveLowHR >= 3 && HealthMonitorService.sleepActive) {
              HealthMonitorService.pushSleepEstimate();
            }
            HealthMonitorService.consecutiveLowHR = 0;
            HealthMonitorService.lowHROnsetTime = 0;
          }
        }
      }, { interval: Constants.HR_SAMPLE_INTERVAL_NS });

      HealthMonitorService.hrSensorActive = true;
      hilog.info(0x0000, TAG, 'HR sensor started (interval: %{public}d ns)',
        Constants.HR_SAMPLE_INTERVAL_NS);
    } catch (err) {
      hilog.error(0x0000, TAG, 'Failed to start HR sensor: %{public}s', String(err));
      HealthMonitorService.hrSensorActive = false;
      // Disable the preference so the toggle reflects reality
      StorageService.setHREnabled(false);
      return;
    }

    // Set up periodic push timer (every 15 min)
    HealthMonitorService.hrIntervalId = setInterval(async () => {
      await HealthMonitorService.pushHRData();
    }, Constants.HR_PUSH_INTERVAL_MS);
  }

  /**
   * Stop HR sensor and push timer.
   */
  public static stopHR(): void {
    if (HealthMonitorService.hrSensorActive) {
      try {
        sensor.off(sensor.SensorId.HEART_RATE);
      } catch (err) {
        hilog.warn(0x0000, TAG, 'Error stopping HR sensor: %{public}s', String(err));
      }
      HealthMonitorService.hrSensorActive = false;
    }

    if (HealthMonitorService.hrIntervalId !== -1) {
      clearInterval(HealthMonitorService.hrIntervalId);
      HealthMonitorService.hrIntervalId = -1;
    }

    HealthMonitorService.hrBuffer = [];
    hilog.info(0x0000, TAG, 'HR monitoring stopped');
  }

  /**
   * Push buffered HR data to the server.
   * Respects debounce (≥ 14 min since last push) and server-enabled check.
   */
  private static async pushHRData(): Promise<void> {
    // Guard: server must be enabled
    const serverEnabled: boolean = await StorageService.isServerEnabled();
    if (!serverEnabled) {
      hilog.info(0x0000, TAG, 'Server disabled, skipping HR push');
      return;
    }

    // Guard: debounce — last push must be ≥ 14 min ago
    const lastPush: number = await StorageService.getLastHRPushTime();
    const now: number = Date.now();
    if (lastPush > 0 && (now - lastPush) < Constants.HR_DEBOUNCE_MS) {
      hilog.info(0x0000, TAG, 'HR push debounced (last push %{public}d ms ago)',
        now - lastPush);
      return;
    }

    // Guard: need at least one sample
    if (HealthMonitorService.hrBuffer.length === 0) {
      hilog.info(0x0000, TAG, 'No HR samples in buffer, skipping push');
      return;
    }

    // Compute values from buffer
    const bufferCopy: number[] = HealthMonitorService.hrBuffer.slice();
    const latestHR: number = bufferCopy[bufferCopy.length - 1];
    const restingHR: number = Math.min(...bufferCopy);

    const payload: HealthPushPayload = {
      heart_rate: latestHR,
      resting_hr: restingHR,
      source: 'watch',
      timestamp: new Date().toISOString()
    };

    const success: boolean = await ServerService.pushHeartRate(payload);
    if (success) {
      await StorageService.setLastHRPushTime(now);
      // Clear buffer after successful push
      HealthMonitorService.hrBuffer = [];
      hilog.info(0x0000, TAG, 'HR push success: %{public}d BPM (resting: %{public}d)',
        latestHR, restingHR);
    }
  }

  // ─────────────────── Sleep ───────────────────

  /**
   * Start sleep detection.
   *
   * MVP approach: The watch does not compute its own sleep duration.
   * The server already imports sleep data from Google Fit via Home Assistant.
   * When sleep monitoring is enabled we:
   *   - Continue HR sampling during all hours (including sleep)
   *   - Detect 3+ consecutive low-HR samples (< 60 BPM) as potential sleep
   *   - On HR recovery, push a tentative sleep estimate with confidence 0.5
   */
  public static startSleep(): void {
    if (HealthMonitorService.sleepActive) {
      hilog.info(0x0000, TAG, 'Sleep monitoring already active');
      return;
    }
    HealthMonitorService.sleepActive = true;
    HealthMonitorService.consecutiveLowHR = 0;
    HealthMonitorService.lowHROnsetTime = 0;
    hilog.info(0x0000, TAG, 'Sleep monitoring started (passive, via HR sensor)');
  }

  /**
   * Stop sleep monitoring.
   */
  public static stopSleep(): void {
    HealthMonitorService.sleepActive = false;
    HealthMonitorService.consecutiveLowHR = 0;
    HealthMonitorService.lowHROnsetTime = 0;
    hilog.info(0x0000, TAG, 'Sleep monitoring stopped');
  }

  /**
   * Push a tentative sleep estimate based on low-HR streak duration.
   * Called when HR recovers after 3+ consecutive low samples.
   */
  private static async pushSleepEstimate(): Promise<void> {
    const serverEnabled: boolean = await StorageService.isServerEnabled();
    if (!serverEnabled) {
      return;
    }

    if (HealthMonitorService.lowHROnsetTime <= 0) {
      return;
    }

    const durationMs: number = Date.now() - HealthMonitorService.lowHROnsetTime;
    const durationHours: number = durationMs / 3600000;

    // Only push if the estimated sleep is at least 30 minutes
    if (durationHours < 0.5) {
      hilog.info(0x0000, TAG, 'Low-HR streak too short (%.1f h), not pushing sleep',
        durationHours);
      return;
    }

    const payload: HealthPushPayload = {
      sleep_duration: Math.round(durationHours * 100) / 100,
      sleep_confidence: 0.5,
      source: 'watch',
      timestamp: new Date().toISOString()
    };

    const success: boolean = await ServerService.pushSleep(payload);
    if (success) {
      hilog.info(0x0000, TAG, 'Sleep estimate pushed: %.2f hours (confidence 0.5)',
        durationHours);
    }
  }

  // ─────────────────── Midnight rollover ───────────────────

  /**
   * Clear HR buffer at midnight. Should be called from a timer or date check.
   */
  public static clearBufferOnMidnight(): void {
    HealthMonitorService.hrBuffer = [];
    HealthMonitorService.consecutiveLowHR = 0;
    HealthMonitorService.lowHROnsetTime = 0;
    hilog.info(0x0000, TAG, 'Midnight rollover: buffers cleared');
  }
}
