# @arkts.lang (ArkTS Base Capability)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-references/js-apis-arkts-lang
> **Last updated:** 2026-01-14

## Overview

The `@arkts.lang` module provides the basic type definition of ArkTS. Currently, it provides the `ISendable` interface.

> **NOTE:** The initial APIs of this module are supported since API version 12. This module can be imported only to ArkTS files (with the file name extension `.ets`).

## Modules to Import

**Supported devices:** Phone | PC/2in1 | Tablet | TV | Wearable

```typescript
import { lang } from '@kit.ArkTS';
```

## lang.ISendable

**Supported devices:** Phone | PC/2in1 | Tablet | TV | Wearable

Parent type of all sendable types except `null` and `undefined`. It does not have any necessary methods or properties.

An `ISendable` object is an instance of the `Object` type in ArkTS.

`ISendable` is mainly used when you want to customize the sendable data structure. Container types in the ArkTS common library implicitly inherit and implement `ISendable`.

**Atomic service API:** This API can be used in atomic services since API version 12.

**System capability:** `SystemCapability.Utils.Lang`

### Example

```typescript
// Construct a custom sendable data structure.
@Sendable
class CustomData implements lang.ISendable {
  data1: number;
  data2: string;
  constructor(data1: number, data2: string) {
    this.data1 = data1;
    this.data2 = data2;
  }
}
```
