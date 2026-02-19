# Custom Components (JavaScript-compatible Web-like Development Paradigm)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/ui-js-custom-components
> **Last updated:** 2026-01-14

## Overview

The ArkUI framework that uses the JavaScript-compatible web-like development paradigm supports custom components for you to extend existing components. You can encapsulate custom private attributes and events into new components to reuse them multiple times in your project. This also improves code readability.

## Building a Custom Component

### comp.hml (Layout)
```html
<!-- comp.hml -->
<div class="item">
  <text class="title-style">{{title}}</text>
  <text class="text-style" onclick="childClicked" focusable="true">Click to view the hidden text.</text>
  <text class="text-style" if="{{showObj}}">hello world</text>
</div>
```

### comp.css (Styles)
```css
/* comp.css */
.item {
  width: 700px;
  flex-direction: column;
  height: 300px;
  align-items: center;
  margin-top: 100px;
}
.text-style {
  width: 100%;
  text-align: center;
  font-weight: 500;
  font-family: Courier;
  font-size: 36px;
}
.title-style {
  font-weight: 500;
  font-family: Courier;
  font-size: 50px;
  color: #483d8b;
}
```

### comp.js (Logic)
```javascript
// comp.js
export default {
  props: {
    title: {
      default: 'title',
    },
    showObject: {},
  },
  data() {
    return {
      showObj: this.showObject,
    };
  },
  childClicked() {
    this.$emit('eventType1', { text: 'Receive the parameters from the child component.' });
    this.showObj = !this.showObj;
  },
}
```

## Importing the Custom Component

### xxx.hml
```html
<!-- xxx.hml -->
<element name='comp' src='../../common/component/comp.hml'></element>
<div class="container">
  <text>Parent component: {{text}}</text>
  <comp title="Custom component" show-object="{{isShow}}" @event-type1="textClicked"></comp>
</div>
```

### xxx.css
```css
/* xxx.css */
.container {
  background-color: #f8f8ff;
  flex: 1;
  flex-direction: column;
  align-content: center;
}
```

### xxx.js
```javascript
// xxx.js
export default {
  data: {
    text: 'Start',
    isShow: false,
  },
  textClicked(e) {
    this.text = e.detail.text;
  },
}
```

## Key Concepts

- The parent component passes customized attributes through `title` to the child component
- The child component receives the attribute value in `props`
- The child component passes text to the parent through the bound event
- The passed value is obtained via `e.detail`
- To bind child component events to the parent, ensure event names meet the requirements for [Basic Usage of Custom Components](https://developer.huawei.com/consumer/en/doc/harmonyos-references/js-components-custom-basic-usage)
