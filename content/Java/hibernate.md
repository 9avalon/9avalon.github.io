---
title : Hibernate
date : 2016-6-23 23:58
updated : 2017-8-28 20:06
collection: Java框架
---

[TOC]

# Hibernate简要介绍

## hibernate组成

* Session

一个轻量级的非线程安全对象，这里的session并不是指的HttpSession，可以理解为JDBC的Session。
SessionFactory负责创建session，而SessionFactory是线程安全的，多个并发线程可以同时访问一个SessionFactory并从中获取Session实例。
而Session是线程不安全的，所以如果有多个线程同时对Session进行操作就会导致Session出错。因为创建的Session实例必须与线程相关。这里会用到ThreadLocal。

* SessionFactory

负责初始化hibernate，可以创建Session，是线程安全的，一般而言SessionFactory会在Hibernate启动时创建一次，因为，为了便于利用，SessionFacctory应该用一个单例模式来实现。

* Transaction

负责相关的事务操作

* Query

负责执行各种数据库查询，一般都Session的createQuery方法创建。

* Configuration

用于读取hibernate配置文件，并生成SessionFactory对象

## Hibernate使用

1、应用程序通过Configuration读取配置文件并生成SessionFactory
`SessionFactory sessionFactory = new Configuration().configure().buildSessionfactory();`

2、通过SessionFactory生成一个Session对象
`Session sesssion = sessionFactory.openSession();`

3、创建事务
`Transaction t = session.beginTransaction()`

4、session操作数据
然后可以用session对象里面的各种方法操作数据,也可以通过session生成一个Query对象执行查询操作。

下面是一个java使用的例子：

```java
Configuration cfg = null;
SessionFactory sf = null;
Session session = null;

//读取配置文件用
cfg = new Configuration().configure();
//创建session，这个非常耗时，应该变成单例模式管理
sf = cfg.buildSessionFactory();

//此处创建session
//需要注意的是这里的session不是web中的session，而是hibernate的session
//session用完后必须关闭
try{
    session = sf.openSession();
    session.beginTransaction();
    session.save(bl);
    session.getTransaction().commit();
}catch (Exception e) {
    //回滚事务
    session.getTransaction().rollback();
}finally{
    //关闭session
    session.close();
    sf.close();
}
```

## 关于缓存

要提升hibernate的性能可以分别从懒加载和缓存入手，其中缓存又分为一级缓存和二级缓存

### 什么是hibernate的二级缓存？

一级缓存：由session管理，当使用Session查询数据时，首先会在该Session内部中查找该对象是否存在，如果有则直接返回。但是因为Session是线程不安全的，这意味着session中的缓存并不能被多个线程共享，因为一级缓存的提升效果不太明显。
二级缓存：二级缓存用来为hibernate配置一种全局的缓存，实现多个线程与事务共享数据。在使用了二级缓存后，当查询数据时，会首先在内部缓存中去查找，如果不存在，接着在二级缓存中查找，都不存在才会到数据库找。
二级缓存适用的场景：数据量小的，修改少的，不会被大量的应用共享的数据（多线程影响性能），不是很重要的数据。

### 缓存的原理

先到session中查找有没有数据，如果没有就去查数据库数据。

### 二级缓存的更新问题

一般来说，二级缓存主要用于那些不常更新的表中。

## 实现分页

Hibernate自带分页机制

```java
Query q = session.createQuery("from table"");
q.setFirstResult(100) //从第一百条记录开始
q.setMaxResults(50) //100条之后的50条
List l = q.list();
```

当然也可以使用sql来进行分页，不过oracle不支持limit会比较麻烦，而mysql支持limit会比较简单。

## 关于调试时，懒加载踩坑

最近踩到的一个坑是，用IDEA进行调试时，代码执行到断点的时候，会默认把代码里面的数据全部 **懒加载** 出来，如果你在代码里面有对元素进行更新或删除的话，会造成DEBUG和RUN执行的结果不一致的问题。
