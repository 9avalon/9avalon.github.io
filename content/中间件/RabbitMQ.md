---
title : RabbitMQ
date : 2019-01-09 01:23:41
collection: MQ
---

## RabbitMQ

### RabbitMQ基本使用

```shell
# 启动
brew services start rabbitmq

# 停止
brew services stop rabbitmq

# 后台地址
http://localhost:15672

# 默认账号
guest/guest
ip:5672
```

### RabbitMQ高可用方案

1.镜像模式

### 交换机类型(Exchange)

1.fanout，将消息发送到与交换机绑定的所有队列中

2.direct，将消息路由到routingkey与bindingkey一致的队列中。

3.topic，按规则模糊匹配，不知道具体的场景是啥。

4.headers，根据发送消息的header属性进行匹配，好像性能会很差。

### NIO

rabbitmq也有使用到NIO，具体集中在网络IO方面，tcp连接复用

### RabbitMQ的心跳监控

```java
    @Resource
    private RabbitTemplate rabbitTemplate;

    public String getVersion() {
        return rabbitTemplate.execute(channel -> {
            Map<String, Object> serverProperties = channel.getConnection().getServerProperties();
            return serverProperties.get("version").toString();
        });
```
