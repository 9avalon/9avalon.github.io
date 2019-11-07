---
title: 程序异常高cpu占用处理方法论
date: 2019-09-29 17:33:17
collection: 问题排查
---

## 现象

cpu高占用，程序无响应。

## 处理流程

### 先排查交易哪些线程高占用CPU

```sh
top -Hp pid  (shift+p 按cpu排序，shift+m 按内存排序)
```

根据当时情况，发现有四个线程CPU占用率一直高占。假设当前占用最高的线程ID是9899

### 查找线程信息

转换成对应的16进制PID (PID为上一步中获取到的线程号)

```sh
printf '%x\n' PID
```

然后使用jstack 获取对应的线程信息

```sh
jstack 进程pid | grep -A 20 '0x7d0'，查找nid匹配的线程，查看堆栈，定位引起高cpu的原因
```

这时候可以根据打印出来的线程信息，来判断程序发生了什么异常。如果打印出来的线程里面，包含GC字样，那基本就可以判断是程序GC引起的异常。

### dump出jvm内存，分析gc原因

```sh
jmap -dump:format=b,file=dumpFileName pid
```

举例（pid是进程的pid）

```sh
jmap -dump:format=b,file=/tmp/dump.dat 31852
```

### 使用mat工具分析dump文件

可以在网上下载一个专业分析jvm内存的工具，如mat来进行分析，找出异常的内存占用对象后，再看代码进行下一步分析。