---
title: Memcached
date: 2016-8-23 18:00:37
collection: 缓存
---

## 安装

sudo apt-get install memcached

## 启动服务

memcached -d -m 128 -p 11111 -u root

启动参数

-p 监听的端口

-l 连接的IP地址, 默认是本机

-d start 启动memcached服务

-d restart 重起memcached服务

-d stop|shutdown 关闭正在运行的memcached服务

-d install 安装memcached服务

-d uninstall 卸载memcached服务

-u 以的身份运行 (仅在以root运行的时候有效)

-m 最大内存使用，单位MB。默认64MB

-M 内存耗尽时返回错误，而不是删除项
-c 最大同时连接数，默认是1024

-f 块大小增长因子，默认是1.25-n 最小分配空间，key+value+flags默认是48

-h 显示帮助

## xmemcached连接

pom

```xml
<!-- memcached Java客户端 -->
<dependency>
    <groupId>com.googlecode.xmemcached</groupId>
    <artifactId>xmemcached</artifactId>
</dependency>
```

java

```java
public void connMemcached() {
    try {
        MemcachedClient client = new XMemcachedClient("121.42.51.33", 11111);
        client.set("key", 3600, "this is the first key");
        Object someObject = client.get("key");
        System.out.println("[key值]:" + someObject.toString());

    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

## 限制ip

memcached本身是没有登陆密码和账号的，因为缓存一般都是用在内网中，不对向外开放，所以要限制外网访问要可以通过限制ip的方式来做限制。

[限制ip](http://www.tuicool.com/articles/bEZVbaU)