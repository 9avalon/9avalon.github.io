---
title : Sentinel
date : 2020-06-15 16:58:34
collection: Spring Cloud Alibaba
---

[TOC]

## Sentinel

### 限流算法

1.Sentinel的底层限流算法是滑动窗口

2.LongAddr来实现计数自增，并发性能比AtomicLong快。