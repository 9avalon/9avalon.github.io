---
title: spring-bean初始化顺序
date: 2020-07-13 11:40:49
collection: Spring
---

1.BeanPostProcess before

2.类初始化构造函数

3.@PostConstruct

4.initalizedBean的afterPropertiesSet

5.xml中的init-method

6.BeanPostProcess after
