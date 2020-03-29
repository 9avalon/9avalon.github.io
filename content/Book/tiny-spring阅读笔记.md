---
title: tiny-spring
date: 2019-10-24 12:09:52
---

1.ClassPathXmlApplicationContext(ApplicationContext)初始化，构造函数传入读取配置文件的地址，和beanFactory

2.ApplicationContext初始化调用refresh，refresh中先开始读取xml文件的bean配置，bean注册到beanFactory中

3.refresh方法第二步对所有的bean进行初始化，aop增强处理
