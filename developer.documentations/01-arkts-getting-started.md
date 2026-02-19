# Getting Started with ArkTS

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/arkts-get-started
> **Last updated:** 2026-01-14

## Overview

ArkTS is the preferred programming language for HarmonyOS application development. Built on the TypeScript (TS) ecosystem, ArkTS extends its functionality while maintaining the basic style of TS. It enhances static check and analysis during development through standardized definitions, improving program execution stability and performance.

## Key Points

Since API version 10, ArkTS further strengthens its static check and analysis in terms of the following aspects:

- **Forced use of static types:** Static typing is one of the most important features of ArkTS. With static typing, the types of variables in the program are definite. In addition, because all types are known at compile time, the compiler can verify the code correctness, thereby reducing the type check at run time and helping improve performance.

- **Forbidden object layout at runtime:** To achieve maximum performance, ArkTS requires that the object layout remain unchanged during program execution.

- **Restricted operator semantics:** For performance and code readability purposes, ArkTS restricts the semantics of some operators. For example, it confines the use of unary plus operators to numbers.

- **Structural typing not supported:** The support for structural typing requires a lot of considerations and careful implementation in the language, compiler, and runtime. Currently, ArkTS does not support this feature.

## Compatibility

ArkTS is compatible with the TS and JavaScript (JS) ecosystem, so that you can write new code or reuse existing code in TS or JS for development.

## Future Direction

ArkTS will continue to accommodate ever-changing application development and running requirements, and gradually provides more features, such as enhanced parallelization and concurrency, improved system, and distributed development paradigm.

## Further Reading

- [ArkTS learning pathways](https://developer.huawei.com/consumer/en/arkts/)
- [ArkTS online courses](https://developer.huawei.com/consumer/en/training/course/video/C101740620697641580)
- [TypeScript to ArkTS Cookbook](https://developer.huawei.com/consumer/en/doc/harmonyos-guides/typescript-to-arkts-migration-guide)
- [About ArkTS Kit](https://developer.huawei.com/consumer/en/doc/harmonyos-guides/arkts-overview)
