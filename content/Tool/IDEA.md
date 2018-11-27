---
title: IntelliJ IDEA
date: 2018-10-8 10:28:24
collection: IDE
---

# IDEA常用技巧

[TOC]

推荐安装vim插件，提升开发效率

还有一点就是将idea的控制台更改为git bash，当然，如果是osx的话，直接用item2就号

## 常用快捷键

列举一些自己最近使用idea依赖，使用得比较频繁的快捷键。

### 查找类

```java
Shift + Shift              // 快速查找，最频繁的一个键，可以搜索几乎所有的东西
  
Ctrl + Shift + F           // 全局搜索
  
Alt + F7                   // 查看调用关系
  
Ctrl + Alt + B             // 查看具体实现
  
Ctrl + P                   // 查看需要传入参数
  
Ctrl + Q                   // 查看类信息
  
Ctrl + E                   // 查看最近修改的类
  
```

### 其他常用类

```java
Alt + Shift + C            // 最近的更改

Alt + Shift + Up/Down      // 向上或下移一行

Ctrl + Shift + Backspace  // 返回上一次修改的地方

Ctrl + Alt + Space         // 自动补全
  
Alt + Enter                // 自动导入

Alt + Insert               // 调出自动构造get、set，构造函数
  
Ctrl + Alt + O             // 去掉引入多余的包
  
Ctrl + Alt + L             // 自动格式化代码
  
Ctrl + /                   // 注释代码
  
Ctrl + Alt + T             // 自动生成try catch等等

Ctrl + Shift + A           // 搜索Action，可以做一些常用的操作，如Build Porject等，有些快捷键如果记不住，可以用这个先过渡一下
```

### 快速输出

```java
sout + ENTER              // 快速打印System.out.println();

psvm + ENTER              // 快速打印main方法
```

## 隐藏idea自动生成文件夹

项目中见到.idea文件有点不爽，把他隐藏掉。

[隐藏文件夹](http://jingyan.baidu.com/article/14bd256e79747dbb6d2612cb.html)

## 单元测试挂代理

有些时候，对接银行需要走代理，可以通过下面的设置让单元测试走代理

```txt
-ea -Dhttp.proxyHost=10.201.5.16 -Dhttp.proxyPort=3128
```

## 序列化自动完成提示

```java
http://blog.csdn.net/tiantiandjava/article/details/8781776
```

## 书签(BookMarks)

通过F11，可以给某段代码做一个标签。Shift+F11展示所有的BookMarks，然后可以对之前的标签重命名。

可以在阅读源码的时候打个标记，方便后面回来看。工作的话，感觉不会太常用。

## IDEA调试技巧

包括放弃当前堆栈，远程调试，修改调试中变量值等实用功能

[IDEA鲜为人知的调试技巧](https://mp.weixin.qq.com/s?src=11&timestamp=1538964762&ver=1169&signature=QU8wFqco2rm8ouHXodJagxz7cQbZnGwot2xbN3P7zLj9cyvl3k0RNeUEvDYqTnrrjLGjE5IdWsOeDqNsm6B3kCngtxRAT0TdIfArOClOyYKFQPha2HgcSnMRIbP6NgTi&new=1)

### 善用coverage

使用IDEA检测自己改动的代码是否被单元测试给覆盖到。