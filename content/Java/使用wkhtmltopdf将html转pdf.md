---
title: html转pdf
date: 2016-6-23 17:14:57
collection: JavaSE
---
[TOC]

## 需求

最近在做简爱网站的时候，需要将做好的html简历转成pdf，找了一圈终于让我找到了一个比较好的实现库，[wkhtmltopdf](http://wkhtmltopdf.org/)

## 原理分析

其实html转pdf最大的困难在于html里面可能会引用到许多的js或者css文件，而如果我们单纯从html源码解析的话是根本解析不来的，网上也有很多其他的html转pdf的包，但是那些包对于html标签的闭合度要求非常高，如果有一个标签没有闭合，那整个程序都跑不了了。所以wkhtmltopdf的思路是，内置一个webkit浏览器（无界面），通过这个webkit打开目标网站，再进行转换。

## 使用

先到网站上把wkhtmltopdf下载下来
http://wkhtmltopdf.org
win和linux版都有，下载完成之后安装即可。（win版的注意把wkhtmltopdf的bin放到环境变量去，方便调用）
然后在编写java程序的时候，调用cmd命令
```shell
wkhtmltopdf 网址 输出地址
```
而由于linux上文件的操作权限控制会比较强，所以建议用用root账号来启动tomcat7，不然会一直报权限不够的错误。
