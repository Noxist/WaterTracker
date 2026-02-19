# ArkUI Overview (About This Kit)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/arkui-overview
> **Last updated:** 2026-02-13

## Overview

ArkUI provides a comprehensive infrastructure for application UI development, including simple UI syntax, a diverse array of UI features (components, layouts, animations, and interaction events), and powerful preview tools.

## Basic Concepts

- **UI:** user interface. You can design the application's UI into multiple functional pages using NavDestination. These pages are managed in a stack structure, and transitions between them, such as navigating to a new page or going back to the previous one, are handled by the navigation container Navigation, enabling functional decoupling within the application.

- **Component:** the smallest unit for UI building and display, for example, a list, grid, button, radio button, progress indicator, and text. You build a UI that meets your needs through flexible combinations of components.

## Two Development Paradigms

ArkUI comes with two development paradigms:

1. **ArkTS-based declarative development paradigm** (declarative development paradigm for short)
2. **JavaScript-compatible web-like development paradigm** (web-like development paradigm for short)

### Declarative Development Paradigm
Uses the ArkTS language, which extends TypeScript with declarative UI syntax, to provide UI drawing capabilities from three dimensions: components, animations, and state management.

### Web-like Development Paradigm
Uses the classical three-stage programming model, in which HML is used for building layouts, CSS for defining styles, and JavaScript for adding processing logic. This development paradigm has a low learning curve for frontend web developers.

### Why Choose Declarative?
- **Higher development efficiency:** The programming mode is closer to natural semantics. You can intuitively describe the UI without caring about how the framework implements UI drawing and rendering.
- **Higher application performance:** The declarative development paradigm does not require the JavaScript framework for managing the page DOM, resulting in more streamlined rendering and update links and less memory usage.
- **Future proof:** The declarative development paradigm will continue to develop as the preferred development paradigm.

## Development Paradigm Support by Application Type

| Application Model | Page Form | Supported Paradigm |
|---|---|---|
| Stage model (recommended) | Application or service page | Declarative development paradigm (recommended) |
| Stage model (recommended) | Widget | Declarative (recommended) / Web-like |
| FA model | Application or service page | Declarative / Web-like |
| FA model | Widget | Web-like |

## Layered API Architecture and Selection Guidelines

- **Declarative development paradigm:** Built on ArkTS, automatically renders UIs by declaring UI structure and state. You define "what the UI should be" rather than managing updates manually. Recommended for new projects.

- **Customization capabilities:** ArkUI supports multi-layer customization capabilities, including custom composition, custom extensions through modifiers, custom node types (FrameNode, RenderNode, BuilderNode), and custom rendering. Recommended for specialized UI requirements.

- **NDK development:** The ArkUI framework offers NDK APIs for building UIs with C/C++, including component creation, UI tree control, attribute configuration, and event handling. Recommended for performance-critical applications.
