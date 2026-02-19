# About This Kit - Introduction to ArkTS

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/introduction-to-arkts
> **Last updated:** 2026-02-13

## Overview

Welcome to the tutorial for ArkTS, a TypeScript-based programming language designed specifically to build high-performance mobile applications! ArkTS is optimized to provide better performance and efficiency, while still maintaining the familiar syntax of TypeScript.

Many current programming languages were not designed with mobile devices in mind, resulting in slow and inefficient applications that drain battery life. As mobile devices continue to become more prevalent in our daily lives, there is a growing need for programming languages optimized for the mobile environment. ArkTS has been specifically designed to address such concerns by prioritizing higher execution efficiency.

## Key Features

- **Based on TypeScript:** ArkTS is based on the popular programming language TypeScript that extends JavaScript by adding type definitions. TypeScript is well-loved by many developers as it provides a more structured approach to coding in JavaScript.

- **Low Runtime Overhead:** One of the key features of ArkTS is its focus on low runtime overhead. ArkTS imposes stricter limitations on the TypeScript's dynamically typed features, reducing runtime overhead and allowing faster execution. By eliminating the dynamically typed features from the language, ArkTS code can be compiled ahead-of-time more efficiently, resulting in faster application startup and lower power consumption.

- **JavaScript Interoperability:** Interoperability with TypeScript and JavaScript was a critical consideration in the ArkTS language design. ArkTS has been designed for seamless JavaScript interoperability, making it easy for the developers to integrate the JavaScript code into their applications and vice versa.

## Topics Covered

- The Basics
- Declarations
- Types
- Operators
- Statements
- Functions (Declaration, Optional/Rest Parameters, Return Type, Scope, Call, Type, Arrow/Lambda, Closure, Overload Signature)
- Classes (Field, Method, Constructor, Visibility Modifiers, Object Literal, Abstract Class)
- Interfaces (Property, Inheritance)
- Generic Type and Function (Generic Class/Interface, Constraints, Default)
- Null Safety (Non-Null Assertion, Null-Coalescing, Optional Chaining)
- Modules (Export, Import, Top-Level Statement)
- Keyword `this`
- Annotation (Custom Annotation)
- ArkUI Support

## Importing SDK APIs

The open capabilities (APIs) provided by the HarmonyOS SDK can be used after import declarations are made:

```typescript
// Method 1: Import a single module under a kit
import { UIAbility } from '@kit.AbilityKit';

// Method 2: Import multiple modules under a kit
import { UIAbility, Ability, Context } from '@kit.AbilityKit';

// Method 3: Import all modules under a kit
import * as module from '@kit.AbilityKit';
```

> **NOTE:** If you use method 3, too many unnecessary modules may be imported. As a result, the compiled HAP file is too large and occupies too many resources.

## Further Reading

- [About ArkTS Kit](https://developer.huawei.com/consumer/en/doc/harmonyos-guides/arkts-overview)
