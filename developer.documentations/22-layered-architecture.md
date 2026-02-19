# Layered Architecture Design (Best Practices)

> **Source:** https://developer.huawei.com/consumer/en/doc/best-practices/bpta-layered-architecture-design
> **Last updated:** 2026-02-13

## Overview

Based on a set of code projects, the layered architecture design by HarmonyOS aims to support Huawei 1+8 all-scenario devices (phones, PCs/2-in-1 devices, etc.), achieving one-time development for multi-device deployment.

The layered architecture comprises three layers: product customization layer, basic feature layer, and common capability layer. It is clear, efficient, and scalable.

## Logic Model

### Product Customization Layer
- Meets personalized requirements of different devices or scenarios
- Includes UI design, resources/configurations, interaction logic, and functionalities
- Enables independent operations among functional modules
- Relies on basic feature layer and common capability layer
- Entry point of the application and UI for user interaction
- Flexibly adjusted and extended for various scenarios

### Basic Feature Layer
- Above the common capability layer
- Stores relatively independent functional UIs and service logic
- Features: high cohesion, low coupling, customizability
- Enables flexible deployment across products
- Delivers stable and basic features (UI components, basic services)
- Functionalities are modularized (e.g., each bottom nav bar option = independent service module)

### Common Capability Layer
- Stores common basic capabilities for cross-application use
- Ensures stability and maintainability
- Includes:
  - **Common UI components:** Highly reusable, ensuring consistent UX across modules
  - **Data management:** Manages data storage/access (application and system data)
  - **External interaction:** Network requests, file I/O, device I/O
  - **Tool library:** String processing, date/time, encryption/decryption, compression

## Development Model

### Product Customization Layer
- Compiled into an **entry HAP** as the main application entry
- Integrates functionalities for various devices
- Can generate same or different HAPs based on UX design per device
- Supports customized multi-target builds for AppGallery Connect

### Basic Feature Layer
- Functionality carried by Ability → designed as **feature HAP**
- Functionality not requiring Ability → designed as **HAR** or **HSP** module

### Common Capability Layer
- Compiled into **HARs**
- Only product customization and basic feature layers can depend on it
- Reverse dependency not allowed
- Provides standard APIs and protocols for the upper layer

## Deployment Model

An application (.app file) is unpacked into multiple entry HAPs and feature HAPs. They are flexibly deployed across diverse devices based on device type and use scenario.

- Entry HAPs represent the application entry
- Feature HAPs encapsulate specific functional modules
- Entry HAPs and feature HAPs, along with dependent HSPs, are distributed and deployed on corresponding devices
- Applications can be adapted and deployed in a modular manner for different devices and scenarios
