# Vision Design

> **Source:** https://developer.huawei.com/consumer/en/doc/design-guides/vision-0000002321377950
> **Last updated:** 2025-10-31

## Overview

Vision is designed to be simple and more intuitive. As a core device in home scenarios, Vision strives to bring families a smart, immersive, and seamless experience.

## Design Principles

- **Immersive:** Vision is a home device suitable for immersive design. Theater-like layouts, smooth transitions, and high-end audio provide immersive experience. The large screen enables unexpected visual effects. Reduce unnecessary elements when designing the interface.

- **Smart:** AI capabilities bring better services and experience. Camera enables video calls from anywhere in the room, air gestures allow control without remote control. Vision provides perceivable and interactive UI experience with hardware and algorithm capabilities.

- **Seamless:** Cross-device collaboration is the core of HarmonyOS. Through flexible switches and collaborative operations between devices, HarmonyOS creates more possibilities in home scenarios. Minimize navigation steps and create smart scenarios for the whole family.

## Device Features

| Aspect | Details |
|---|---|
| **Hardware Features** | Screen: large screen with high resolution. Audio: advanced audio I/O. Camera: good front camera. HDMI ports: multiple ports for connecting to STBs, game consoles, computers. |
| **Usage Methods** | Remote use: Users are 1.5-4m away. Two interactive modes: cursor pointing (Ultra remote) and focus navigation (focus-moving remote control). |
| **Applicable Scenarios** | Home entertainment (movies, games), home atmosphere. |

## Application and Service Design

### Ensuring Basic Experience
Comply with basic experience requirements. For example, ensure click targets are large enough for comfortable interaction.

### Designing Application and Service Experience
- **Leverage system components:** Use standard system components (bottom tabs, title bars, pop-up boxes).
- **Adopt appropriate architecture:** Entertainment apps use immersive layout; efficiency apps use left-right column layout.
- **Maximize remote control utility:** Complement pointing/focusing with button interactions.

### Supporting System Features
Leverage HarmonyOS system features and comply with their UX requirements.

## Application Architecture

Three Vision application architectures:

1. **Immersive layout:** For content apps (video, music) providing immersive experience.
2. **Column layout:** For tool apps (file management, settings) providing efficient experience.
3. **General layout:** Displays full content on home screen through sub-tabs for rich-content apps.

## Ultra Remote

Unique hardware feature of single-framework Vision, providing point-and-click experience from a distance.

- **Power button:** Power off or screen off.
- **Home button:** Press returns to home; press-and-hold enters task center.
- **OK button & Touchpad:** Press clicks pointed object; slides switch screens.
- **Arrow button:** Moves focus in four directions; adjusts video progress.
- **Menu button:** Press shows hidden features; press-and-hold enters Control Panel.
- **Voice button:** Press-and-hold wakes Celia.
- **Volume button:** Adjusts volume.

## Available System Features
- [Notifications](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-notification-0000001793074217)
- [Live View](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-live-view-0000001955186861)
- [Service Widget](https://developer.huawei.com/consumer/en/doc/design-guides/system-features-service-widget-0000002087671904)
- [Audio Control Panel](https://developer.huawei.com/consumer/en/doc/design-guides/broadcasting-control-0000001957017133)

## Human-Machine Interaction
- [Cursor Interaction](https://developer.huawei.com/consumer/en/doc/design-guides/hmi-cursor-0000001795531205)
- [Focus Navigation](https://developer.huawei.com/consumer/en/doc/design-guides/hmi-focus-0000001748650376)
