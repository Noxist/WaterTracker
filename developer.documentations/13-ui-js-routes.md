# Defining Page Routes (JavaScript-compatible Web-like Development Paradigm)

> **Source:** https://developer.huawei.com/consumer/en/doc/harmonyos-guides/ui-js-building-ui-routes
> **Last updated:** 2026-01-14

## Overview

An application generally consists of more than one page. For example, a music application may come with a music list page and a playback page. You need to link these pages through the page router to implement redirection as required.

The page router finds the target page based on the page URI. The following describes how to implement redirection between two pages:

1. In the Project window of DevEco Studio, choose `src > main > js > MainAbility`. Right-click the pages folder and choose **New > JS Page** from the shortcut menu to create the detail page.
2. Call `router.push()` to navigate users to the detail page.
3. Call `router.back()` to navigate users to the index page.

## Building the Page Layout

The index and detail pages each contains a Text component and a Button component for page switching:

### index.hml
```html
<!-- index.hml -->
<div class="container">
  <text class="title">This is the index page.</text>
  <button type="capsule" value="Go to the second page" class="button" onclick="launch"></button>
</div>
```

### detail.hml
```html
<!-- detail.hml -->
<div class="container">
  <text class="title">This is the detail page.</text>
  <button type="capsule" value="Go back" class="button" onclick="launch"></button>
</div>
```

## Setting Page Styles

```css
/* index.css / detail.css */
.container {
  width: 100%;
  height: 100%;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.title {
  font-size: 50px;
  margin-bottom: 50px;
}
```

## Implementing Redirection

Call `router.push()` to add the page URI to the route stack. Import the router module before calling:

### index.js
```javascript
// index.js
import router from '@ohos.router';
export default {
  launch() {
    router.push({
      url: 'pages/detail/detail',
    });
  },
}
```

### detail.js
```javascript
// detail.js
import router from '@ohos.router';
export default {
  launch() {
    this.getUIContext().getRouter().back();
  },
}
```
