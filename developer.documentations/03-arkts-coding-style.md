# ArkTS Coding Style Guide

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/arkts-coding-style-guide
> **Last updated:** 2026-02-13

## Purpose

Based on the language characteristics of ArkTS, as well as industry standards and practices, this guide provides coding guide for improving code standardization, security, and performance. This guide is applicable when you use ArkTS for coding during application development.

## Source

ArkTS further enhances static check and analysis while maintaining the basic syntax style of TypeScript. Some rules are selected from the TypeScript and JavaScript Coding Style Guide, providing standards for ArkTS-specific syntax to improve code readability and execution performance.

## Terms

| Abbreviation | Full Name |
|---|---|
| ArkTS | ArkTS programming language |
| TS | TypeScript programming language |
| JS | JavaScript programming language |
| ESObject | JS/TS object in ArkTS cross-language calls |

## Principle

- **Rule:** a convention that must be complied with
- **Recommendation:** a convention that must be considered

---

## Naming

### Properly Name Identifiers to Make Them Easy to Read
- Clearly express the intent. Do not use single letters or non-standard abbreviations.
- Use correct English words in line with the English grammar.
- Ensure that the statement is clear and unambiguous.

### Use UpperCamelCase for Class Names, Enum Names, and Namespace Names
Classes are named in upper camel case. Class names are usually nouns or noun phrases.

```typescript
class User {
  username: string
  constructor(username: string) {
    this.username = username;
  }
  sayHi() {
    console.info('hi' + this.username);
  }
}

enum UserType {
  TEACHER = 0,
  STUDENT = 1
};
```

### Use lowerCamelCase for Variable Names, Method Names, and Parameter Names
A function is usually named as a verb or verb phrase in lower camel case.

```typescript
let msg = 'Hello world';
function sendMsg(msg: string) {
  // todo send message
}
let userName = 'Zhangsan';
function findUser(userName: string) {
  // todo find user by user name
}
```

### Use Uppercase Letters for Constant Names and Enum Value Names
Separate words by underscores. Express complete semantics.

```typescript
const MAX_USER_SIZE = 10000;
enum UserType {
  TEACHER = 0,
  STUDENT = 1
};
```

### Do Not Use Negative Boolean Variable Names
Avoid defining negative Boolean variable names (e.g., `isNoError`). Use positive forms instead (`isError`).

---

## Format

### Use Spaces for Indentation
Use spaces only to indent. Preferentially use two-space indentation in most scenarios. Use four spaces in line break scenarios.

### Use No More Than 120 Characters in Each Line
The code line width should not be too long to improve readability.

### Use Braces in Conditional Statements and Loop Statements
Always add braces `{}` to the execution body of `if`, `for`, `do`, and `while` statements.

### Indent case and default in the switch Statement Block
Use two spaces to indent the case or default statement.

### Keep a Consistent Line Break Style for Expressions
Place operators at the end of lines when breaking.

### Do Not Put Multiple Variable Definitions in a Line
Each statement should declare only one variable.

### Use Spaces to Highlight Keywords and Important Information
- Add a space between keywords (`if`, `for`, `while`, `switch`) and open parentheses
- No space between method name and open parentheses
- Add space between `else`/`catch` and close brace
- Spaces around binary operators

### Use Single Quotation Marks for Strings

```typescript
let message = 'world';
```

### Object Literals with More Than Four Properties
Place each property at a separate line.

### Put else/catch in Same Line as Close Parenthesis

```typescript
if (flag) {
  // ...
} else {
  // ...
}
```

### Put Open Brace and Statement in Same Line

```typescript
function foo() {
  // ...
}
```

---

## Programming Practices

### Add Accessible Modifiers for Class Properties
Use `private`, `protected`, and `public` access modifiers appropriately.

### Do Not Omit 0s Before/After Decimal Point
Use `0.5` not `.5`, use `2.0` not `2.`.

### Use Number.isNaN() to Check NaN
Never compare directly with `Number.NaN`.

### Preferentially Use Array Object Methods
Use `forEach()`, `map()`, `every()`, `filter()`, `find()`, `findIndex()`, `reduce()`, and `some()`.

### Do Not Assign Values in Control Conditional Expressions
Assign values above the control statement.

### Do Not Use return/break/continue/throw in finally
Ensure the finally code block can stop properly.

### Do Not Use ESObject
ESObject is mainly for ArkTS and TS/JS cross-language calls. Using it elsewhere causes extra performance overhead.

### Use T[] for the Array Type
Use `T[]` instead of `Array<T>` for better readability.

```typescript
let x: number[] = [1, 2, 3];
let y: string[] = ['a', 'b', 'c'];
```
