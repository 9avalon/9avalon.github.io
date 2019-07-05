---
title: Spring-Retry
date: 2019-07-03 10:25:37
collection: Spring
---

很实用的一个重试组件

## 引入POM

```xml
<dependency>
    <groupId>org.springframework.retry</groupId>
    <artifactId>spring-retry</artifactId>
</dependency>
```

## Application启动类

添加 *@EnableRetry* 注解

## 编写服务

在需要重试的方法上面，添加该注解

```java
@Retryable(value= {IOException.class},maxAttempts = 5,backoff = @Backoff(delay = 5000L,multiplier = 1))
```
