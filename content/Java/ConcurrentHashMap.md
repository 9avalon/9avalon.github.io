---
title: ConcurrentHashMap
date: 2020-03-31 10:18:12
collection: 集合类型
---

## put

1. 判断桶是否初始化了，未初始化则进行初始化，关键技术，CAS
2. 通过(n-1)&key.hashCode()定位桶位置
3. 定位到桶后，通过synchronized锁住桶，然后遍历list或者tree，然后通过尾插法插入

## 扩展

Thread.yield();

CAS, ABA问题

头插法，1.7的jdk会导致resize死循环

1.8已经去掉了segment，改为每个桶都加锁，原因1，增加并发度，原因2，降低复杂度。

get方法不加锁，因此不能保证强一致性。
