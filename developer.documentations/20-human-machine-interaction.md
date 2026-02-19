# Human-Machine Interaction (Wearable)

> **Source:** https://developer.huawei.com/consumer/en/doc/design-guides/human-machine-interaction-0000002167648022
> **Last updated:** 2026-02-14

## Crown

As a unique interaction method for wearables, the crown supports various operations such as rotate, press, double-press, and press-and-hold. Standardize these operations for a consistent and responsive user experience.

### Principles
- **Universal applicability:** Crown interactions should be widely applicable, easy to use, and support function customization.
- **Timely response:** The watch responds to crown operations through the watch face and voice notifications. Timeliness is crucial both in feedback speed and information updates.

### Types

The number of crowns varies depending on the watch. For a watch with a digital crown and Action button:

#### Digital Crown Gestures

**Press:**
- On the home screen: Activates the application list through Launcher.
- On other screens: Returns to the watch face (with exceptions below).

**Exceptions:**
1. During a workout session: Displays the pause/resume screen.
2. On incoming call screen: Silences the call. Second press returns to previous screen.
3. When an alarm goes off: Snoozes the alarm, then displays home screen.
4. With live view notification: Hides the notification.

**Press and hold (3s):** Goes to the power-off/restart screen.

**Double-press:** Displays the multi-task selection screen. Press again to return to watch face.

**Rotate:** Universal input method for scrolling, scaling, and data adjustment.

#### Action Button Gestures

**Press:**
1. On home screen: Launches workout application by default (customizable).
2. On application screen: Triggers specific functions (customizable by third-party apps, e.g., start/pause stopwatch).

**Press and hold (1s):** Activates voice assistant (can be disabled in settings).

## Smart Gestures

Smart gestures are a unique interaction mode for wearables beyond screen, crown, and button interaction. Users can leverage finger taps and knuckle swipes to navigate components in one-handed operation scenarios.

### Scenario Selection Principles

Focus on convenience rather than comprehensive accessibility:
1. Time-sensitive features (phone calls, alarms)
2. Frequently used features (skipping tracks in media player)
3. One-handed scenarios (remote photo taking)

### Types

- **Primary focus confirmation gesture:** A double-tap gesture with the thumb and index fingertips.
- **Secondary focus switching gesture:** A double-slide gesture where the thumb moves along the side of the index finger from the second joint toward the fingertip.

### How to Use

Smart gestures are optimally implemented in applications requiring immediate actions:
- Snoozing or dismissing an alarm
- Answering or declining a call
- Activating the camera shutter remotely

**Design guidelines:**
1. Design an obvious circle component that can be tapped on the screen.
2. Avoid using non-circular components, such as arc buttons.
3. Limit the number of buttons on each screen to three or fewer.
