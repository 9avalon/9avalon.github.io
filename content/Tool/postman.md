---
title : postman
date : 2018-9-17 10:38:51
---

# PostMan

## 执行前脚本

设置时间撮全局变量

```javascript

pm.globals.unset("orderNo");

var timestamp = Math.round(new Date().getTime()/1000)

pm.globals.set("orderNo", timestamp);

```

在body中使用`{{orderNo}}`进行引用