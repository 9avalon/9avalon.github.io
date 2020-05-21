---
title : Queue
date : 2020-04-06 13:51:23
collection : 集合类型
---

## ArrayBlockingQueue

1.用可重入锁，控制入队和出队的线程安全。ReentrantLock

2.线程安全

## LinkedBlockingQueue

1.读写两个锁分离，理论上来说，并发性能会比ArrayBlockingQueue好

## PriorityQueue

1.非线程安全

2.默认是小顶堆，要实现大顶堆要重写比较方法

3.offer、poll、peek

## DelayQueue

1. 优先队列实现
2. 最快过期的在最前面准备出栈。

Demo

()[https://juejin.im/post/5bf945b95188254e2a04329b]