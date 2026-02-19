/**
 * ServerService — communicates with a remote health monitoring server.
 *
 * The server implements two endpoints:
 *   POST /api/water/report       — receives the watch's current hydration status
 *   GET  /api/water/instruction   — returns a drinking instruction for the watch
 *
 * Authentication is via Bearer token in the Authorization header.
 * Server URL and token are configured in Constants.ets.
 *
 * @see README.md for the full API contract
 */
import http from '@ohos.net.http';
import { StorageService } from './StorageService';
import { DayLog, ServerResponse, HydrationCurveData, VelocityWarning, HealthPushPayload } from '../model/WaterModel';
import { Constants } from '../common/Constants';
import hilog from '@ohos.hilog';

const TAG: string = 'ServerService';

class WatchStatusReport {
  public device_id: string = 'watch_ultra2';
  public current_intake: number = 0;
  public daily_goal: number = 0;
  public entry_count: number = 0;
  public last_drink_time: string = '';
  public timestamp: string = '';
}

class ServerTestResult {
  public success: boolean = false;
  public message: string = '';
}

class ReportResponseInstruction {
  public message: string = '';
  public recommended_amount: number = 0;
  public priority: string = '';
  public deadline_minutes: number = 0;
  public daily_target_override: number = 0;
  public timestamp: string = '';
  public hydration_curve: HydrationCurveData | null = null;
  public velocity_warning: VelocityWarning | null = null;
  public events_today: number = 0;
  public adaptive_curve: object | null = null;
}

class ReportResponse {
  public status: string = '';
  public instruction: ReportResponseInstruction | null = null;
}

function buildServerHeader(token: string): object {
  if (token.length > 0) {
    return JSON.parse(`{"Authorization":"Bearer ${token}","Content-Type":"application/json"}`);
  }
  return JSON.parse('{"Content-Type":"application/json"}');
}

export class ServerService {

  /**
   * POST current hydration status to the server.
   * The server now returns the instruction inline, so we parse and return it.
   * Returns the embedded ServerResponse on success, or null on error.
   */
  public static async reportStatus(): Promise<ServerResponse | null> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    if (url.length === 0) {
      return null;
    }

    const log: DayLog = await StorageService.getTodayLog();
    const goal: number = await StorageService.getDailyGoal();
    const lastEntry = log.entries.length > 0
      ? log.entries[log.entries.length - 1]
      : null;

    // Use serverBase + localDelta so the watch never resets the server's total.
    // Example: server reported 1200 ml, watch added 250 ml locally → send 1450 ml.
    const serverBase: number = await StorageService.getServerBaseIntake();
    const trueIntake: number = serverBase + log.totalIntake;

    const report: WatchStatusReport = new WatchStatusReport();
    report.device_id = 'watch_ultra2';
    report.current_intake = trueIntake;
    report.daily_goal = goal;
    report.entry_count = log.entries.length;
    report.last_drink_time = lastEntry ? new Date(lastEntry.timestamp).toISOString() : '';
    report.timestamp = new Date().toISOString();

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/water/report`, {
        method: http.RequestMethod.POST,
        header: buildServerHeader(token),
        extraData: JSON.stringify(report),
        connectTimeout: 15000,
        readTimeout: 15000
      } as http.HttpRequestOptions);

      const ok: boolean = response.responseCode >= 200 && response.responseCode < 300;
      if (ok && response.result) {
        hilog.info(0x0000, TAG, 'Status reported: %{public}d ml', log.totalIntake);
        // Parse the merged response which contains the instruction
        const parsed: ReportResponse = JSON.parse(response.result as string) as ReportResponse;
        if (parsed.instruction !== null && parsed.instruction !== undefined) {
          const ins: ReportResponseInstruction = parsed.instruction;
          const sr: ServerResponse = {
            message: ins.message,
            recommended_amount: ins.recommended_amount,
            priority: ins.priority,
            deadline_minutes: ins.deadline_minutes,
            daily_target_override: ins.daily_target_override,
            timestamp: ins.timestamp,
            hydration_curve: ins.hydration_curve,
            velocity_warning: ins.velocity_warning,
            events_today: ins.events_today,
            adaptive_curve: ins.adaptive_curve ?? null
          };
          return sr;
        }
        return null;
      } else {
        hilog.warn(0x0000, TAG, 'Report HTTP %{public}d', response.responseCode);
        return null;
      }
    } catch (err) {
      hilog.error(0x0000, TAG, 'Report error: %{public}s', String(err));
      return null;
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * GET the latest drinking instruction from the server.
   * Returns null when no instruction is available or on error.
   */
  public static async fetchInstruction(): Promise<ServerResponse | null> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    if (url.length === 0) {
      return null;
    }

    const log: DayLog = await StorageService.getTodayLog();
    const goal: number = await StorageService.getDailyGoal();
    const lastEntry = log.entries.length > 0
      ? log.entries[log.entries.length - 1]
      : null;
    const lastTime: string = lastEntry
      ? new Date(lastEntry.timestamp).toISOString()
      : '';

    const query: string =
      `?current_intake=${log.totalIntake}` +
      `&daily_goal=${goal}` +
      `&last_drink_time=${encodeURIComponent(lastTime)}`;

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/water/instruction${query}`, {
        method: http.RequestMethod.GET,
        header: buildServerHeader(token),
        connectTimeout: 15000,
        readTimeout: 15000
      } as http.HttpRequestOptions);

      if (response.responseCode === 200 && response.result) {
        const parsed: ServerResponse = JSON.parse(response.result as string) as ServerResponse;
        if (parsed.message && parsed.message.length > 0) {
          hilog.info(0x0000, TAG, 'Instruction: %{public}s', parsed.message);
        }
        return parsed;
      }
      return null;
    } catch (err) {
      hilog.error(0x0000, TAG, 'Fetch error: %{public}s', String(err));
      return null;
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * DELETE the most recent water event on the server (undo/delete propagation).
   * Calls DELETE /api/water/intake/last.
   * Returns the new server total in ml, or -1 on error.
   */
  public static async deleteLastIntake(): Promise<number> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    if (url.length === 0) {
      return -1;
    }

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/water/intake/last`, {
        method: http.RequestMethod.DELETE,
        header: buildServerHeader(token),
        connectTimeout: 15000,
        readTimeout: 15000
      } as http.HttpRequestOptions);

      if (response.responseCode >= 200 && response.responseCode < 300 && response.result) {
        const parsed = JSON.parse(response.result as string) as Record<string, Object>;
        const newTotal: number = parsed['new_total_ml'] as number;
        hilog.info(0x0000, TAG, 'Deleted last intake, server total now %{public}d ml', newTotal);
        return newTotal;
      }
      hilog.warn(0x0000, TAG, 'Delete-last HTTP %{public}d', response.responseCode);
      return -1;
    } catch (err) {
      hilog.error(0x0000, TAG, 'Delete-last error: %{public}s', String(err));
      return -1;
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * Quick connectivity check — GETs /api/status which returns service info.
   */
  public static async testConnection(): Promise<ServerTestResult> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    const result: ServerTestResult = new ServerTestResult();
    if (url.length === 0) {
      result.success = false;
      result.message = 'No server URL';
      return result;
    }

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/status`, {
        method: http.RequestMethod.GET,
        header: buildServerHeader(token),
        connectTimeout: 10000,
        readTimeout: 10000
      } as http.HttpRequestOptions);

      if (response.responseCode === 200) {
        result.success = true;
        result.message = 'Connected';
      } else if (response.responseCode === 401) {
        result.success = false;
        result.message = 'Invalid token (401)';
      } else {
        result.success = false;
        result.message = `HTTP ${response.responseCode}`;
      }
      return result;
    } catch (err) {
      result.success = false;
      result.message = 'Connection failed';
      return result;
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * Push a heart-rate snapshot to the server.
   * POST /api/health with source="watch".
   */
  public static async pushHeartRate(payload: HealthPushPayload): Promise<boolean> {
    return ServerService.pushHealth(payload);
  }

  /**
   * Push a sleep summary to the server.
   * POST /api/health with source="watch", sleep_duration + sleep_confidence.
   */
  public static async pushSleep(payload: HealthPushPayload): Promise<boolean> {
    return ServerService.pushHealth(payload);
  }

  /**
   * Internal helper — POST /api/health with the given payload.
   */
  private static async pushHealth(payload: HealthPushPayload): Promise<boolean> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    if (url.length === 0) {
      return false;
    }

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/health`, {
        method: http.RequestMethod.POST,
        header: buildServerHeader(token),
        extraData: JSON.stringify(payload),
        connectTimeout: 15000,
        readTimeout: 15000
      } as http.HttpRequestOptions);

      const ok: boolean = response.responseCode >= 200 && response.responseCode < 300;
      if (ok) {
        hilog.info(0x0000, TAG, 'Health push OK: HR=%{public}s sleep=%{public}s',
          String(payload.heart_rate ?? '-'), String(payload.sleep_duration ?? '-'));
      } else {
        hilog.warn(0x0000, TAG, 'Health push HTTP %{public}d', response.responseCode);
      }
      return ok;
    } catch (err) {
      hilog.error(0x0000, TAG, 'Health push error: %{public}s', String(err));
      return false;
    } finally {
      httpRequest.destroy();
    }
  }

  /**
   * One-shot test push (used by the “Test” buttons in Settings).
   * Sends a dummy snapshot with source="watch" and heart_rate=0.
   * Returns { success, message } like testConnection().
   */
  public static async testHealthPush(): Promise<ServerTestResult> {
    const url: string = await StorageService.getServerUrl();
    const token: string = await StorageService.getServerToken();
    const result: ServerTestResult = new ServerTestResult();
    if (url.length === 0) {
      result.success = false;
      result.message = 'No server URL';
      return result;
    }

    const testPayload: HealthPushPayload = {
      source: 'watch',
      heart_rate: 0
    };

    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(`${url}/api/health`, {
        method: http.RequestMethod.POST,
        header: buildServerHeader(token),
        extraData: JSON.stringify(testPayload),
        connectTimeout: 10000,
        readTimeout: 10000
      } as http.HttpRequestOptions);

      if (response.responseCode === 200) {
        result.success = true;
        result.message = 'Health endpoint OK';
      } else if (response.responseCode === 401) {
        result.success = false;
        result.message = 'Invalid token (401)';
      } else {
        result.success = false;
        result.message = `HTTP ${response.responseCode}`;
      }
      return result;
    } catch (err) {
      result.success = false;
      result.message = 'Connection failed';
      return result;
    } finally {
      httpRequest.destroy();
    }
  }
}
