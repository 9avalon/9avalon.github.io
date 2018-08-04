---
title : mybatis
date : 2018-08-01 01:29:31
---

# MyBatis

## 简介

MyBatis 是一款优秀的持久层框架，它支持定制化 SQL、存储过程以及高级映射。MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。MyBatis 可以使用简单的 XML 或注解来配置和映射原生信息，将接口和 Java 的 POJOs(Plain Old Java Objects,普通的 Java对象)映射成数据库中的记录。

### hibernate与mybatis

orm框架的本质是简化编程中操作数据库的编码，发展到现在基本上就剩两家了，一个是宣称可以不用写一句SQL的hibernate，一个是可以灵活调试动态sql的mybatis,两者各有特点，在企业级系统开发中可以根据需求灵活使用。发现一个有趣的现象：传统企业大都喜欢使用hibernate,互联网行业通常使用mybatis。

hibernate特点就是所有的sql都用Java代码来生成，不用跳出程序去写（看）sql，有着编程的完整性，发展到最顶端就是spring data jpa这种模式了，基本上根据方法名就可以生成对应的sql

mybatis初期使用比较麻烦，需要各种配置文件、实体类、dao层映射关联、还有一大推其它配置。当然mybatis也发现了这种弊端，初期开发了generator可以根据表结果自动生产实体类、配置文件和dao层代码，可以减轻一部分开发量；后期也进行了大量的优化可以使用注解了，mybatis最强大的地方，还是在于其强大的sql定制能力。

## 从零开始

