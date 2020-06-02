---
title : Raft
date : 2020-05-18 23:38:36
collection : Raft
draft: true
---

1.raft协议，leader在commit了一条日志后，立刻挂了，那其他节点如何处理这条日志？

依靠选举机制，多数派的才能被选上，来保证未commit的一定会被commit

2.zab

基本机制与raft相同，不同点
