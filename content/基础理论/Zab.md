---
title : Zab
date : 2020-05-18 23:38:36
collection : 一致性共识算法
---

## 角色

1. Leader，整个zk集群只有一个Leader
2. Follower，从

## 主从同步

1. 读：可以从Follower读，支持多副本读，但是数据不一定是最新的。所以说zk其实并非是强一致性的。但最终一致
2. 写：只能Leader进行写，如果写请求到了Follower，会转发给Leader.

### 广播方式

1. Leader向所有Follower发送事务提议，此时需要过半Follower响应ACK。少于一半则直接失败。

2. Leader收到过半ACK后，向所有Follower发送commit，然后follower也提交事务。