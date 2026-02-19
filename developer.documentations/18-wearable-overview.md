# Wearable Design Overview

> **Source:** https://developer.huawei.com/consumer/en/doc/design-guides/wearable-overview-0000002197410498
> **Last updated:** 2026-02-14

## Overview

Complementing mobile phones, wearables have become essential personal devices in users' lives, serving as life assistants, health managers, and fitness coaches.

To design excellent wearable applications, you need to be familiar with and make full use of the hardware features, usage methods, interaction modes, and applicable scenarios.

## Hardware & Usage Characteristics

| Aspect | Details |
|---|---|
| **Hardware Features** | Screen: compact screen with mid-to-high resolution. Audio: advanced audio I/O. Location: GPS and related technologies. Sensors: heart rate, pulse oximeter, gyroscope, accelerometer, etc. |
| **Usage Methods** | Worn on either wrist. Cross-hand touchscreen control or one-handed control. |
| **Interaction Modes** | Touchscreen gestures, physical buttons (crowns, side buttons), voice-based interaction for hands-free operation. |
| **Applicable Scenarios** | Daily life management, fitness tracking, health monitoring, fashion accessories. |

## Application Design

### Ensuring Basic Experience
- **Real-time notifications:** Leverage portability for timely alerts with adaptive filtering to suppress redundant notifications.
- **Lightweight interaction:** Prioritize core functionalities for compact displays. Position wearables as mobile complements, not replacements.

### Designing Application Experience
- **Leverage system components:** Use standard system components (navigation bars, buttons, etc.) to ensure baseline usability.
- **Adopt appropriate architecture:** Choose flat hierarchies for single-purpose apps. See [Application Architecture](https://developer.huawei.com/consumer/en/doc/design-guides/application-architecture-0000002202799801).
- **Ensure display compatibility:** Design based on wearable screen shapes to prevent visual truncation.
- **Maximize crown/button utility:** Complement touchscreen gestures with tactile interactions. See [Crown](https://developer.huawei.com/consumer/en/doc/design-guides/human-machine-interaction-0000002167648022).
- **Design for one-handed control:** Implement focus-driven navigation and thumb-zone optimization.
- **Enable cross-device continuity:** Maintain task continuity between paired devices (phone + watch).

### Supporting System Features
- Leverage system features like service widgets for real-time status notifications.
- Comply with UX requirements of system features.

## Available System Features
- [Notifications](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-notification-0000001793074217)
- [Live View](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-live-view-0000001955186861)
- [Service Widget](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-service-widget-0000002087671904)

## Complying with Unified HarmonyOS Design Specifications
- **Colors:** Customized adaptations for wearable-specific system colors. See [Color](https://developer.huawei.com/consumer/en/doc/design-guides/color-0000001776857164).
- **Application icons:** Circular icon shapes following distinct rendering specifications. See [Application Icons](https://developer.huawei.com/consumer/en/doc/design-guides/application-icon-0000001953444009).
- **System icons:** Filled and solid-style icons preferred over outlined variants for compact screens. See [System Icons](https://developer.huawei.com/consumer/en/doc/design-guides/system-icons-0000001929854962).
