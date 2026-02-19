# Adding Interactions (JavaScript-compatible Web-like Development Paradigm)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/ui-js-building-ui-interactions
> **Last updated:** 2026-01-14

## Overview

You can make the UI interactive by binding events to components. This topic describes how to associate a click event with `<div>`, `<text>`, and `<image>` components to build a like button.

## Example: Like Button

The like button is implemented by binding a click event to a `<div>` component, which contains an `<image>` component and a `<text>` component.

- The `<image>` component displays the liked or unliked state. The click event handler toggles the image source between the liked and unliked versions.
- The `<text>` component displays the number of likes, which is updated synchronously in the click event handler.

### HML (Layout)

```html
<!-- xxx.hml -->
<!-- Like button -->
<div>
  <div class="like" onclick="likeClick">
    <image class="like-img" src="{{likeImage}}" focusable="true"></image>
    <text class="like-num" focusable="true">{{total}}</text>
  </div>
</div>
```

### CSS (Styles)

```css
/* xxx.css */
.like {
  width: 104px;
  height: 54px;
  border: 2px solid #bcbcbc;
  justify-content: space-between;
  align-items: center;
  margin-left: 72px;
  border-radius: 8px;
}
.like-img {
  width: 33px;
  height: 33px;
  margin-left: 14px;
}
.like-num {
  color: #bcbcbc;
  font-size: 20px;
  margin-right: 17px;
}
```

### JavaScript (Logic)

```javascript
// xxx.js
export default {
  data: {
    likeImage: '/common/unLike.png',
    isPressed: false,
    total: 20,
  },
  likeClick() {
    var temp;
    if (!this.isPressed) {
      temp = this.total + 1;
      this.likeImage = '/common/like.png';
    } else {
      temp = this.total - 1;
      this.likeImage = '/common/unLike.png';
    }
    this.total = temp;
    this.isPressed = !this.isPressed;
  },
}
```

In addition, a variety of form components, such as switches, tags, and pickers, are available to help you create flexible and engaging interactions in your layouts.
