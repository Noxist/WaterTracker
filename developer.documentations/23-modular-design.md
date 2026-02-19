# Modular Design (Best Practices)

> **Source:** https://developer.huawei.com/consumer/en/doc/best-practices/bpta-modular-design
> **Last updated:** 2026-02-13

## Overview

Service modularization is one of the core principles of modern software projects. It improves system maintainability and scalability by disassembling a large, complex system into functional modules that are smaller and easier to manage and understand. Each functional module is an independent unit with clearly defined APIs and responsibilities.

In HarmonyOS application development, modularization requires an application be split into multiple functional modules, each responsible for a specific function or feature. These modules can be independently developed, compiled, and deployed, or flexibly combined and called on different devices.

## Application Package Structure Concept

During modular design, consider the HarmonyOS application package structure, which defines how the application is organized. See [Application Package Structure in Stage Model](https://developer.huawei.com/consumer/en/doc/harmonyos-guides/application-package-structure-stage).

## UIAbility Design

Service logic is carried by UIAbility. Select and design proper abilities based on service devices and requirements. Consider multi-task multi-window forms for better UX.

**Single ability examples:** Single-window or multi-task app (e.g., game). Deploy UIAbility in a single HAP.

**Multiple abilities scenarios:**
- Multi-window app: Each window = different UIAbility in a feature HAP
- Extended features (widgets, sharing): Hosted by ExtensionAbility in separate feature HAPs

## Module Type Selection

Primary module types: feature HAP, HAR, and HSP. Scenarios:

### Shared Module
For large-scale projects with multiple teams, develop HAR modules as independent projects. Publish to private ohpm repository for cross-application sharing.

### On-Demand Module
For low-engagement features, implement as on-demand modules downloaded later from AppGallery. Benefits:
- Smaller package size
- Fewer system resources
- Easier architectural evolution

### Impact of Multiple HAPs/HSPs Referencing the Same HAR
When both HAP and HSP reference the same HAR, the singleton pattern in the HAR is damaged. Replace HSPs with HARs when possible to prevent concurrent references.

## Single-HAP Project

### Without On-Demand Loading
Use HAR modules. Advantages: no additional installation/loading costs, better compiler optimization, simple architecture.

### With On-Demand Loading
Implement on-demand modules as HSPs. Balance application size vs. startup performance:
- **Application Size First:** Encapsulate common dependencies into HSP
- **Performance First:** Directly depend on common HAR packages

## Multi-HAP Project

### With Common Capability Modules
- **Performance First:** Use HARs only. May result in larger package but better performance.
- **Application Size First:** Encapsulate shared HARs into common HSP to reduce redundancy.

### Without Common Capability Modules
Rare / small applications. Follow single-HAP structure.

## Summary

Select appropriate modular project model based on technical architecture:
- Feature HAPs: Independently run/installable modules
- HSP on-demand modules: Seldom-used non-independent features
- HARs: Shared modules via ohpm repository
- Common HSP module shells: Minimize application size in multi-HAP/on-demand scenarios

These models should evolve with service needs, choosing between HAPs, HARs, and HSPs according to specific requirements.
