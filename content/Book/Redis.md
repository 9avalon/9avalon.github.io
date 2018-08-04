---
title : Redis
date : 2018-07-29 16:53:37
---

[TOC]

# redis

## Redis简单介绍

Redis是一款高性能的key-value内存数据库，目前业界主要用途是拿来做缓存。

### Redis特点

1. 单进程单线程，且数据都存储在内存中，因为性能非常高，官方给出的性能数据是，读的速度是110000次/s,写的速度是81000次/s。

2. 原子性，每一个操作有么成功，要么失败。同时，redis是单线程的

3. 支持多种数据结构，如Set和List等，而memcached只支持最简单的简单字符串。

### 最常用的命令

#### 连接远程服务器

1.连接远程服务器，需要redis客户端

```shell
redis-cli -h <ip> -p <port> -a <password>
```

例如，现在要连接到主机为127.0.0.1，端口为6379的redis服务器上

```shell
redis-cli -h 127.0.0.1 -p 6379
```

#### Key

查找key

```shell
KEYS egKey
KEYS egK*
KEYS *gK*
```

删除key

```shell
DEL key[key ...]
==> DEL egKey1
==> DEL egKey1 egKey2
```

#### String

设置key和key的过期时间(毫秒)

```shell
输入 SET egKey redis PX 10086
输出 OK

输入 GET egKey
输出 "redis"
```

查看key过期时间

```shell
输入 TTL finance-test
输出 10069
```

自增，如果key存在则加一，不存在则先初始化为0，再加一，具备原子性

```shell
INCR egIntKey
```

#### Hash

常用命令: hget/hset

应用场景：存储一个用户的信息，其中包括用户的ID，姓名，年龄和生日，通过用户ID，我们希望可以获得该用户的姓名或者年林或者生日。

#### List

应用场景：list的应用场景非常多，如twitter的关注列表，粉丝列表，排行榜等，都可以用Redis的list结构来实现。

常用命令: lpush/rpush/lpop/rpop/lrange/lindex

#### Set

应用场景：set与list类似，但不同的是set的插入是无序的，但是set可以去重。当你需要存储一个列表数据，又不希望出现重复数据时，set是一个很好的选择。

常用命令：sadd/spop/smembers/sunion

更多命令用法：[命令参数](http://doc.redisfans.com/index.html)

## 常见用途

### 缓存

性能卓越，纯内存操作，非常适合用来做内存数据库。

### 分布式锁

1.通过命令SETNX和EXPIRE组合，可以实现分布式锁。

```shell
SETNX key value
```

将 key 的值设为 value ，当且仅当 key 不存在。

若给定的 key 已经存在，则 SETNX 不做任何动作。

返回值:

设置成功，返回 1 。

设置失败，返回 0 。

风险点：因为SETNX和EXPIRE需要进行组合，导致无法保证其原子性，如果在SETNX后，程序被意外地kill掉，会导致当前的锁无过期时间，请求则会被一直阻塞，这时候可以在加锁前检查锁是否存在，且判断其是否有过期时间，如果无过期时间，则设置过期时间，且拒绝该次请求。

### 消息队列（MQ）

利用Redis的发布订阅功能

下图展示了频道 channel1 ， 以及订阅这个频道的三个客户端 —— client2 、 client5 和 client1 之间的关系

![订阅](http://www.runoob.com/wp-content/uploads/2014/11/pubsub1.png)

当有新消息通过 PUBLISH 命令发送给频道 channel1 时， 这个消息就会被发送给订阅它的三个客户端：

![发送消息](http://www.runoob.com/wp-content/uploads/2014/11/pubsub2.png)

redis实现的mq功能比较简单，可管理型会比较差。

目前公司老项目用的是自研的redis作为mq，新项目则转用rocketmq。

## 分布式

codis，有兴趣的童鞋可以看看

## 公司Redis组建的使用

wiki地址.....