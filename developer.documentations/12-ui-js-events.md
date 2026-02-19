# Defining Gesture Events (JavaScript-compatible Web-like Development Paradigm)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/ui-js-building-ui-event
> **Last updated:** 2026-01-14

## Overview

A gesture represents a semantic action (for example, touch, click, or long press) recognized from one or more input events. A gesture lifecycle may consist of multiple sequential events from its initiation to completion.

## Supported Events

### Touch Events
- **touchstart:** triggered when a touch point is placed on the screen.
- **touchmove:** triggered when a touch point is moved along the screen.
- **touchcancel:** triggered when a touch is interrupted, for example, by an incoming call or a system alert.
- **touchend:** triggered when a touch point is removed from the screen.

### Click Event
- **click:** triggered when the user quickly taps and releases the screen.

### Long Press Event
- **longpress:** triggered when the user touches and holds the same position on the screen for a sustained period.

## Example

### HML (Layout)

```html
<!-- xxx.hml -->
<div class="container">
  <div class="text-container" onclick="click">
    <text class="text-style">{{onClick}}</text>
  </div>
  <div class="text-container" ontouchstart="touchStart">
    <text class="text-style">{{touchstart}}</text>
  </div>
  <div class="text-container" ontouchmove="touchMove">
    <text class="text-style">{{touchmove}}</text>
  </div>
  <div class="text-container" ontouchend="touchEnd">
    <text class="text-style">{{touchend}}</text>
  </div>
  <div class="text-container" ontouchcancel="touchCancel">
    <text class="text-style">{{touchcancel}}</text>
  </div>
  <div class="text-container" onlongpress="longPress">
    <text class="text-style">{{onLongPress}}</text>
  </div>
</div>
```

### CSS (Styles)

```css
/* xxx.css */
.container {
  width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.text-container {
  margin-top: 30px;
  flex-direction: column;
  width: 600px;
  height: 70px;
  background-color: #0000FF;
}
.text-style {
  width: 100%;
  line-height: 50px;
  text-align: center;
  font-size: 24px;
  color: #ffffff;
}
```

### JavaScript (Logic)

```javascript
// xxx.js
export default {
  data: {
    touchstart: 'touchstart',
    touchmove: 'touchmove',
    touchend: 'touchend',
    touchcancel: 'touchcancel',
    onClick: 'onclick',
    onLongPress: 'onLongPress',
  },
  touchCancel: function (event) {
    console.info('event is', JSON.stringify(event));
    this.touchcancel = 'canceled';
  },
  touchEnd: function(event) {
    console.info('event is', JSON.stringify(event));
    this.touchend = 'ended';
  },
  touchMove: function(event) {
    console.info('event is', JSON.stringify(event));
    this.touchmove = 'moved';
  },
  touchStart: function(event) {
    console.info('event is', JSON.stringify(event));
    this.touchstart = 'touched';
  },
  longPress: function() {
    this.onLongPress = 'longPressed';
  },
  click: function() {
    this.onClick = 'clicked';
  },
}
```
