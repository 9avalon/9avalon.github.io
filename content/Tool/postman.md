---
title : Postman
date : 2018-9-17 10:38:51
---

## PostMan

## 执行前脚本

设置时间撮全局变量

```javascript

pm.globals.unset("orderNo");

var timestamp = Math.round(new Date().getTime()/1000)

pm.globals.set("orderNo", timestamp);

```

在body中使用`{{orderNo}}`进行引用

## 脚本例子

记录一个自己写的脚本，作用是参数加密

```javascript
const paramsString = request.url.split('?')[1];
const eachParamArray = paramsString.split('&');
var str = ""
for (var p = 0; p < eachParamArray.length; p++) {
    if (eachParamArray[p].indexOf("encrypt") == 0) {
        continue;
    } else {
        if (p == eachParamArray.length-2){
            str = str + eachParamArray[p]
        } else {
            str = str + eachParamArray[p] + "&"
        }
    }
}
str = encodeURI(str)
console.log(str)
pm.environment.unset("encrypt");
pm.environment.set("encrypt", CryptoJS.MD5(str).toString());
```