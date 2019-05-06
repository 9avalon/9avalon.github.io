---
title: SpringBoot
date: 2017-09-20 00:28
collection: 微服务
---

[TOC]

暂时只收录一些遇到的坑

## 不使用默认的Spring Boot parent模板

在parent的pom中，`<dependencyManagement>`节点中增减下面的代码即可。

```xml
<!-- spring boot-->
<dependency>
    <!-- Import dependency management from Spring Boot -->
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-dependencies</artifactId>
    <version>1.4.3.RELEASE</version>
    <type>pom</type>
    <scope>import</scope>
</dependency>
```