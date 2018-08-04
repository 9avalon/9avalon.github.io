---
title: spring
date: 2016-6-24 16:57:46
collection: Java框架
---

[TOC]

# 搭建Spring环境

2018-7-16 移除了spring搭建的相关内容，因为搭环境这些，一般配合网上的一些教程资源，既可以轻松搭建。

# Spring事务

## 注解控制事务(**推荐**)

spring配置文件中加入

```xml
    <!-- 对数据源进行事务管理 -->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
          p:dataSource-ref="dataSource"/>

    <!-- 允许使用注解进行事务配置 -->
    <tx:annotation-driven transaction-manager="transactionManager" />
```

然后在类的开头就可以加上注解 `@Transactional`

### 关于事务注解的一些坑点

最近看了一下部分AOP的源码。。起初是因为想不通，为什么一个方法调用同一个类里面的带事务方法，事务不起作用。

看了源码之后明白了。因为Spring创建代理对象，是在获取Bean的时候生成代替的。

例如说A这个类，有不带事务的B方法和带事务的C方法。Spring发现你要调用A的B方法，于是他就去看看B需不需要被代理(通过AOP)，若发现不需要，就直接从Bean容器中给你返回了A类，然后调用带事务的C方法时，就是直接本类调用了。因为同类调用不需要向Spring获取Bean。

### 事务注解和AOP注解

当事务注解和自定义的AOP注解在同一个方法上面时，就需要自定义注解的顺序，在Spring中配置事务的地方有一个属性**order**，这个属性的值越小，则执行优先级最高，事务的默认级别是最高的。

## AOP层控制事务(不推荐)

不建议使用该方式，建议使用注解的方式来使用事务

这种方式不好的地方有两点，第一点是，对刚接触业务的同事不透明，第二是，可能会导致一些不需要事务的方法，也加入了事务。

```xml
<!-- 通知 -->
<tx:advice id="txAdvice" transaction-manager="transactionManager">
  <tx:attributes>
  <!-- 传播行为 -->
  <!-- 顺序，*优先级最低，处理查询数据的操作默认不开启事务 -->
  <tx:method name="get*" propagation="SUPPORTS" read-only="true" />
  <tx:method name="find*" propagation="SUPPORTS" read-only="true" />
  <tx:method name="search*" propagation="SUPPORTS" read-only="true" />
  <tx:method name="load*" propagation="SUPPORTS" read-only="true" />
  <tx:method name="*" propagation="REQUIRED" />
  </tx:attributes>
</tx:advice>
```

经过实践，发现*号的优先度是最低的。这样配置可以实现除了get，find，search，load等纯读取方法外，其余方法都是会开启事务。

## 手工管理事务(不推荐)

```java
@Autowired
private DataSourceTransactionManager txManager;
```

```java
DefaultTransactionDefinition def = new DefaultTransactionDefinition();
def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
// 开启事务
TransactionStatus status = txManager.getTransaction(def);
try{
  txManager.commit(status);
}catch(Exception e){
  txManager.rollback(status);
}

```

# AOP的使用

在这里就只是简单的列举一下实践，更多的使用以后再归纳整理。

举个例子：
首先，aop我们一般会放在service中，我们先定义一个接口名字，名字就叫ISleepServiceInter

```java
public interface ISleepServiceInter {
    public void sleep();
}
```

然后，我们实现写一个他的实现类SleepServiceImpl

```java
@Service
public class SleepServiceImpl implements ISleepServiceInter{

    @Override
    public void sleep() {
        System.out.println("蛤铪：睡觉ing。。。。。。");
    }
}
```

然后我们开始写aop的类

```java
public class SleepAop implements MethodBeforeAdvice, AfterReturningAdvice{

    @Override
    public void afterReturning(Object arg0, Method arg1, Object[] arg2, Object arg3) throws Throwable {
        System.out.println("蛤铪：昨天搞的这个大新闻啊。。。。exicted！");
    }

    @Override
    public void before(Method arg0, Object[] arg1, Object arg2) throws Throwable {
        System.out.println("蛤铪：睡觉之前，先搞个大新闻！");
    }
}
```

最后配置xml文件

```xml
    <!-- aop发生的地点 -->
    <bean id="sleepCutPoint" class="org.springframework.aop.support.JdkRegexpMethodPointcut">
        <property name="pattern" value=".*sleep" />
    </bean>

    <bean id="sleepAop" class="com.houmingjian.mblog.service.aop.SleepAop"></bean>  

    <bean id="sleepHelperAdvisor" class="org.springframework.aop.support.DefaultPointcutAdvisor">
        <property name="advice" ref="sleepAop"/>
        <property name="pointcut" ref="sleepCutPoint"/>
     </bean>

    <bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator"/>  
```

当然也可以用注释的方法来做~

# Spring-cache

2018-7-16更新：Spring-cache因为缺少时间

[注释驱动的 Spring cache 缓存介绍](https://www.ibm.com/developerworks/cn/opensource/os-cn-spring-cache/)

# Quartz定时任务

添加jar包依赖

```xml
<!--定时任务-->
<dependency>
    <groupId>org.quartz-scheduler</groupId>
    <artifactId>quartz</artifactId>
</dependency>
```

定时任务测试类

```java
@Service("testTask")
public class TestTask {
    Logger logger  = Logger.getLogger(TestTask.class);

    public void run() {
        logger.info("执行定时任务");
    }
}

```

Spring配置文件中配置该任务

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:util="http://www.springframework.org/schema/util"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-3.2.xsd
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx-3.2.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-3.2.xsd
    http://www.springframework.org/schema/util
    http://www.springframework.org/schema/util/spring-util-3.2.xsd">

    <bean id="testTaskDetail"         class="org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean">
        <!-- 指定任务类 -->
        <property name="targetObject" ref="testTask" />
        <!-- 指定任务执行的方法 -->
        <property name="targetMethod" value="run" />
    </bean>

    <bean id="cronTrigger" class="org.springframework.scheduling.quartz.SimpleTriggerBean">
        <property name="jobDetail" ref="testTaskDetail" />
        <property name="startDelay" value="0" />
        <property name="repeatInterval" value="2000" />
    </bean>

    <bean class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
        <property name="triggers">
            <list>
                <ref bean="cronTrigger" />
            </list>
        </property>
    </bean>
</beans>
```

cronExpression表达式

| 序号 | 说明 | 是否必填 | 允许填写的值     | 允许的通配符  |
| ---- | ---- | -------- | ---------------- | ------------- |
| 1    | 秒   | 是       | 0-59             | , - * /       |
| 2    | 分   | 是       | 0-59             | , - * /       |
| 3    | 小时 | 是       | 0-23             | , - * /       |
| 4    | 日   | 是       | 1-31             | , - * ? / L W |
| 5    | 月   | 是       | 1-12             | , - * /       |
| 6    | 周   | 是       | 1-7              | , - * ? / L # |
| 7    | 年   | 否       | empty或1970-2099 | , - * /       |

常见例子：

```java
* * * * * ? //每一秒
0/3 * * * * ? //每三秒一次
0 0/3 * * * ?  //每三分钟一次
```

# spring引用jar包里面的配置文件

我们使用maven进行多模块开发时，一般会进行多模块开发。这里举个例子，我们现在有两个模块，分别是A和B，其中A是服务层，B是web层。

A主要是核心业务的代码实现，而B用于向外提供http服务和连接A项目。这两个项目都有spring，这时候我们一般是会将A打包成jar，然后供B调用。但这时候问题来了，B怎么才能同时接管A的spring呢

这时候会用到spring配置文件中的 `<import>` 标签，将jar包中的spring配置文件引入到B中。

```java
<import resource="classpath*:/spring/spring-common.xml" />
<import resource="classpath*:/spring/spring-mybatis.xml" />
<import resource="classpath*:/spring/spring-jms.xml" />
```

# Spring Test回滚

若想执行测试用例的时候回滚，则在测试用例的头部加入

```
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
```

# Spring加载顺序比静态类加载慢的问题

这是我在17-2-20日碰到的一个小坑，记录下来看看。

很简单的一个例子：

```java
public class SettingContext implements InitializingBean {

    private static SettingService settingServiceStatic;
    @Autowired
    private SettingService settingService;

    public static String getValue(String key,String... defaultValue) {
        if (settingServiceStatic == null) {
            if (defaultValue != null && defaultValue.length > 0)
                return defaultValue[0];
            return null;
        }
        return settingServiceStatic.getValue(key);
    }

    @Override
    public  void afterPropertiesSet() throws Exception {
        SettingContext.settingServiceStatic = appSettingService;
    }
}
```

上面的代码会有一个问题，当启动应用时，会先加载静态类，后加载spring容器，当spring容器还没加载完全时，settingService为空时，刚好有一个服务会调用到静态的getValue方法，导致settingServiceStatic被置为空了。服务就会出现异常。

# 自定义bean初始化后行为

有三种方式可以自定义bean初始化后的行为

1. 通过bean实现`InitializingBean`接口，重写`afterPropertiesSet`方法
2. 在xml中定义`init-method`方法
3. 通过`@PostConstruct`注解

需要注意的点是

* `@PostConstruct`是JSR-250注解，类似于`@Resource`
* 三者的执行顺序 `@PostConstruct` > `afterPropertiesSet` > `init-method`

个人更倾向于使用第三种注解的方式来做bean初始化后的操作














