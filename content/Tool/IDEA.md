---
title: IntelliJ IDEA
date: 2016-8-4 23:05:52
collection: IDE
---

[TOC]

推荐安装vim插件，提升开发效率

还有一点就是将idea的控制台更改为git bash，超级方便

### 常用快捷键

列举一些自己最近使用idea依赖，使用得比较频繁的快捷键。

#### 查找类

```java
Shift + Shift              // 快速查找  
  
Ctrl + Shift + F           // 全局搜索
  
Alt + F7                   // 查看调用关系
  
Ctrl + N                   // 查找类
  
Ctrl + Alt + B             // 查看具体实现
  
Ctrl + LeftClick           // 查看类
  
Ctrl + P                   // 查看需要传入参数
  
Ctrl + Q                   // 查看类信息
  
Ctrl + E                   // 查看最近修改的类
  
```

#### 其他常用类

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
```



#### 快速输出

```java
sout + ENTER              // 快速打印System.out.println();

psvm + ENTER              // 快速打印main方法
```



#### 隐藏idea自动生成文件夹

项目中见到.idea文件不爽，把他隐藏掉

[隐藏文件夹](http://jingyan.baidu.com/article/14bd256e79747dbb6d2612cb.html)



#### 单元测试挂代理

```
-ea -Dhttp.proxyHost=10.201.5.16 -Dhttp.proxyPort=3128
```



#### 序列化自动完成提示

```
http://blog.csdn.net/tiantiandjava/article/details/8781776
```

