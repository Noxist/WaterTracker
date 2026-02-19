# Application Architecture and Application Navigation (Wearable)

> **Source:** https://developer.huawei.com/consumer/en/doc/design-guides/application-architecture-0000002202799801
> **Last updated:** 2025-10-31

## Overview

Comply with the following specifications when designing the application architecture and navigation for wearable devices.

## Application Architecture

The information layout must adapt to your application's actual content, with dedicated UI layouts for non-empty-state and empty-state screens.

### Non-Empty-State Layouts

**Title bar + Content area:**
In general cases, a non-empty screen must clearly inform users of the current application or hierarchy through the title.

**Top button + Content area:**
When implementing a button for features like add or create, consider using a round button placed on the top of the screen, which can be a floating action button.

### Empty-State Layouts

Empty-state layouts exclude navigation elements (such as titles) and employ a minimalist design (image + text) to convey the current UI state.

**Button + Text description:**
For an empty-state screen that involves user interactions, place the button and its accompanying text description in the center of the screen.

**Icon + Text description:**
For an empty-state screen without any operation, the icon and description are displayed in the center of the screen.

## Application Navigation

Navigation is mainly used to show the path and notify users of the current location. There are two major types:

### Hierarchical Navigation

Hierarchical navigation consists of parent pages and child pages. A parent page can have one or more child pages. It enables the UI to clearly present a complex menu with multiple levels.

**Home screen with a multifunctional menu:**
The application presents a multifunctional menu as the landing page, where each child page operates independently.

**Home screen displaying only core functionality:**
The application prioritizes core functionality on the home screen. A simple right-swipe gesture reveals the menu panel.

### Lateral Navigation

If content needs more than one screen, spread content across multiple screens at the same level. Three types:

**Horizontal navigation:**
Spread content horizontally across multiple screens to avoid losing information near the edges of a circular display.

**Vertical navigation:**
Spread content vertically across multiple screens, expanding the watch space upwards and downwards.

**Tile navigation:**
Tile the content vertically in the extended area of the same page without a screen switch.

### How to Use

Different navigation types are often combined in practice. Complex functions may need hierarchical + lateral navigation together.

For example:
- A sports application uses both hierarchical navigation and vertical navigation to display exercise information
- Huawei Music on the watch allows users to access secondary navigation panels via a right-swipe gesture
