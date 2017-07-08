---
title: spring
date: 2016-6-24 16:57:46
collection: Java框架
---
[TOC]

### 搭建Spring环境
1、导入所有的Spring包

```xml
<!-- spring开始 -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-core</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-web</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-oxm</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-tx</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aop</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context-support</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
</dependency>
```


2、配置web.xml

如果工程没有web的部分，或者并没有使用到spring-mvc，则不需要配置该文件

```xml
<!DOCTYPE web-app PUBLIC
        "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
        "http://java.sun.com/dtd/web-app_2_3.dtd" >
<web-app>
    <display-name>Archetype Created Web Application</display-name>

    <!-- Spring的配置文件 -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring/spring-common</param-value>
    </context-param>

    <!--log4j-->
    <context-param>
        <param-name>log4jConfigLocation</param-name>
        <param-value>WEB-INF/log4j.properties</param-value>
    </context-param>

    <!-- 编码过滤器 -->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <async-supported>true</async-supported>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

    <!-- Spring监听器 -->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    <!-- 防止Spring内存溢出监听器 -->
    <listener>
        <listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>
    </listener>
    <listener>
        <listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>
    </listener>

    <!-- Spring MVC servlet -->
    <servlet>
        <servlet-name>SpringMVC</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:spring/spring-mvc.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
        <async-supported>true</async-supported>
    </servlet>
    <servlet-mapping>
        <servlet-name>SpringMVC</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <welcome-file-list>
        <welcome-file>/index.jsp</welcome-file>
    </welcome-file-list>
</web-app>
```

配置spring-common.xml文件
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
      http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
      http://www.springframework.org/schema/context
      http://www.springframework.org/schema/context/spring-context.xsd">

    <!-- 扫描文件（自动将service层注入） -->
    <context:component-scan base-package="com.houmingjian.practice.service"/>

    <!-- 扫描dao层 -->
    <context:component-scan base-package="com.houmingjian.practice.dao"/>
</beans>
```

然后就是配置Spring的数据库事项了。在hibernate中有提到。



### 整合数据库

##### 配置jdbc信息

jdbc.properties

```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc\:mysql\://localhost\:3306/practice
jdbc.username=root
jdbc.password=root
```

##### 整合hibernate

spring的配置文件中加入（最好是新建一个spring配置文件spring-hibernate）

```xml
<!-- 读取jdbc文件 -->
	<bean class="org.springframework.beans.factory.config.PreferencesPlaceholderConfigurer">
		<property name="locations">
			<list>
				<value>classpath:jdbc.properties</value>
			</list>
		</property>
	</bean>

	<bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
		<!-- 用户名 -->
		<property name="user" value="${jdbc.username}" />
		<!-- 用户密码 -->
		<property name="password" value="${jdbc.password}" />
		<property name="driverClass" value="${jdbc.driver}" />
		<property name="jdbcUrl" value="${jdbc.url}" />
		<!--连接池中保留的最大连接数。默认值: 15 -->
		<property name="maxPoolSize" value="20" />
		<!-- 连接池中保留的最小连接数，默认为：3 -->
		<property name="minPoolSize" value="2" />
		<!-- 初始化连接池中的连接数，取值应在minPoolSize与maxPoolSize之间，默认为3 -->
		<property name="initialPoolSize" value="2" />

		<!--最大空闲时间，60秒内未使用则连接被丢弃。若为0则永不丢弃。默认值: 0 -->
		<property name="maxIdleTime" value="60" />

		<!-- 当连接池连接耗尽时，客户端调用getConnection()后等待获取新连接的时间，超时后将抛出SQLException，如设为0则无限期等待。单位毫秒。默认: 
			0 -->
		<property name="checkoutTimeout" value="3000" />

		<!--当连接池中的连接耗尽的时候c3p0一次同时获取的连接数。默认值: 3 -->
		<!-- <property name="acquireIncrement" value="2"/> -->

		<!--定义在从数据库获取新连接失败后重复尝试的次数。默认值: 30 ；小于等于0表示无限次 -->
		<property name="acquireRetryAttempts" value="0" />

		<!--重新尝试的时间间隔，默认为：1000毫秒 -->
		<property name="acquireRetryDelay" value="1000" />

		<!--关闭连接时，是否提交未提交的事务，默认为false，即关闭连接，回滚未提交的事务 -->
		<property name="autoCommitOnClose" value="false" />

		<!--如果为false，则获取连接失败将会引起所有等待连接池来获取连接的线程抛出异常，但是数据源仍有效保留，并在下次调用getConnection()的时候继续尝试获取连接。如果设为true，那么在尝试获取连接失败后该数据源将申明已断开并永久关闭。默认: 
			false -->
		<property name="breakAfterAcquireFailure" value="false" />

		<!--每60秒检查所有连接池中的空闲连接。默认值: 0，不检查 -->
		<property name="idleConnectionTestPeriod" value="60" />
		<!--c3p0全局的PreparedStatements缓存的大小。如果maxStatements与maxStatementsPerConnection均为0，则缓存不生效，只要有一个不为0，则语句的缓存就能生效。如果默认值: 
			0 -->
		<property name="maxStatements" value="100" />
		<!--maxStatementsPerConnection定义了连接池内单个连接所拥有的最大缓存statements数。默认值: 0 -->
		<property name="maxStatementsPerConnection" value="10" />
	</bean>

	<bean id="sessionFactory" class="org.springframework.orm.hibernate4.LocalSessionFactoryBean">
		<!-- 配置数据源 -->
		<property name="dataSource" ref="dataSource" />
		<!-- 扫描包 -->
		<property name="packagesToScan" value="org.daxiang.resume.po"> </property>
		<!--hibernate参数配置 -->
		<property name="hibernateProperties">
			<props>
				<prop key="hibernate.dialect"> org.hibernate.dialect.MySQLDialect </prop>
				<prop key="hibernate.show_sql">true</prop>
				<prop key="hibernate.current_session_context_class">org.springframework.orm.hibernate4.SpringSessionContext</prop>
				<prop key="jdbc.use_scrollable_resultset">false</prop>
				<!-- <prop key="hibernate.hbm2ddl.auto">none</prop> 
					 <prop key="hibernate.jdbc.fetch_size">50</prop> 
					 <prop key="hibernate.jdbc.batch_size">30</prop> -->
			</props>
		</property>
	</bean>
```

web.xml中加入

```
<!-- 配置Session -->
<filter>
<filter-name>openSession</filter-name>
<filter-class>org.springframework.orm.hibernate4.support.OpenSessionInViewFilter</filter-class>
</filter>
<filter-mapping>
<filter-name>openSession</filter-name>
<url-pattern>/*</url-pattern>
</filter-mapping>
```



##### 整合mybatis

spring-mybatis配置文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
      http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
      http://www.springframework.org/schema/context
      http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">

    <!-- 引入jdbc配置文件 -->
    <context:property-placeholder location="classpath:jdbc.properties"/>

    <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource" init-method="init"
          destroy-method="close">
        <property name="driverClassName">
            <value>${jdbc.driver}</value>
        </property>
        <property name="url">
            <value>${jdbc.url}</value>
        </property>
        <property name="username">
            <value>${jdbc.username}</value>
        </property>
        <property name="password">
            <value>${jdbc.password}</value>
        </property>
        <!-- 连接池最大使用连接数 -->
        <property name="maxActive">
            <value>20</value>
        </property>
        <!-- 初始化连接大小 -->
        <property name="initialSize">
            <value>1</value>
        </property>
        <!-- 获取连接最大等待时间 -->
        <property name="maxWait">
            <value>60000</value>
        </property>
        <!-- 连接池最大空闲 -->
        <property name="maxIdle">
            <value>20</value>
        </property>
        <!-- 连接池最小空闲 -->
        <property name="minIdle">
            <value>3</value>
        </property>
        <!-- 自动清除无用连接 -->
        <property name="removeAbandoned">
            <value>true</value>
        </property>
        <!-- 清除无用连接的等待时间 -->
        <property name="removeAbandonedTimeout">
            <value>180</value>
        </property>
        <!-- 连接属性 -->
        <property name="connectionProperties">
            <value>clientEncoding=UTF-8</value>
        </property>
    </bean>

    <!-- spring和MyBatis完美整合，不需要mybatis的配置映射文件 -->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource" />
        <!-- 加载mybatis的配置文件 -->
        <property name="configLocation" value="classpath:mybatis/mybatis-config.xml"></property>
        <!-- 自动扫描mapping.xml文件 -->
        <property name="mapperLocations" value="classpath:com/houmingjian/practice/dao/*.xml"></property>
    </bean>

    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg index="0" ref="sqlSessionFactory" />
    </bean>

    <!-- spring与mybatis整合配置，扫描所有dao -->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer"
          p:basePackage="com.houmingjian.practice.dao"
          p:sqlSessionFactoryBeanName="sqlSessionFactory"/>

    <!-- 对数据源进行事务管理 -->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
          p:dataSource-ref="dataSource"/>

    <!-- 允许使用注解进行事务配置 -->
    <tx:annotation-driven transaction-manager="transactionManager" />

</beans>
```





### Spring事务配置

##### AOP层控制事务

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



##### 注解控制事务

spring配置文件中加入

```xml
    <!-- 对数据源进行事务管理 -->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
          p:dataSource-ref="dataSource"/>

    <!-- 允许使用注解进行事务配置 -->
    <tx:annotation-driven transaction-manager="transactionManager" />
```

然后在类的开头就可以加上注解

```
@Transactional
```

如果想手工管理事务，则可以使用编程式事务管理。

```
@Autowired
private DataSourceTransactionManager txManager;
```

```
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



### Spring整合Mybaits

##### 配置mybatis的环境

引入mybatis相关的包

```xml
<!-- mybatis开始 -->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
</dependency>
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis-spring</artifactId>
</dependency>
<dependency>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-core</artifactId>
    <version>1.3.2</version>
</dependency>     
```

在resource文件夹下新建mybatis-config文件，里面存放的是mybatis的配置

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!-- 别名 -->
    <typeAliases>
        <!-- 批量扫描domain别名 -->
        <package name="com.houmingjian.practice.po"/>
    </typeAliases>
</configuration>
```

这篇讲得不错

http://hwak.iteye.com/blog/1611970

### AOP
**在这里就只是简单的列举一下实践，更多的使用以后再归纳整理。**
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



最近看了一下部分AOP的源码。。起初是因为想不通，为什么一个方法调用同一个类里面的带事务方法，事务不起作用。看了源码之后明白了。因为Spring创建代理对象，是在获取Bean的时候生成代替的，例如说A这个类，有不带事务的B方法和带事务的C方法。Spring发现你要调用A的B方法，于是他就去看看B需不需要被代理，发现不需要，就直接从Bean容器中给你返回了A类，然后调用带事务的C方法时，就是直接本类调用了。因为同类调用不需要向Spring获取Bean。



#### 事务注解和AOP注解

当事务注解和自定义的AOP注解在同一个方法上面时，就需要自定义注解的顺序，在Spring中配置事务的地方有一个属性**order**，这个属性的值越小，则执行优先级最高，事务的默认级别是最高的。



### Spring-cache

[注释驱动的 Spring cache 缓存介绍](https://www.ibm.com/developerworks/cn/opensource/os-cn-spring-cache/)



### Quartz定时任务

添加jar包依赖

```xml
<!--定时任务-->
<dependency>
	<groupId>org.quartz-scheduler</groupId>
	<artifactId>quartz</artifactId>
</dependency>
```



定时任务测试类

```
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

| 序号   | 说明   | 是否必填 | 允许填写的值          | 允许的通配符        |
| ---- | ---- | ---- | --------------- | ------------- |
| 1    | 秒    | 是    | 0-59            | , - * /       |
| 2    | 分    | 是    | 0-59            | , - * /       |
| 3    | 小时   | 是    | 0-23            | , - * /       |
| 4    | 日    | 是    | 1-31            | , - * ? / L W |
| 5    | 月    | 是    | 1-12            | , - * /       |
| 6    | 周    | 是    | 1-7             | , - * ? / L # |
| 7    | 年    | 否    | empty或1970-2099 | , - * /       |

常见例子：

```
* * * * * ? //每一秒
0/3 * * * * ? //每三秒一次
0 0/3 * * * ?  //每三分钟一次
```



### spring引用jar包里面的配置文件

我们使用maven进行多模块开发时，一般会进行多模块开发。这里举个例子，我们现在有两个模块，分别是A和B，其中A是服务层，B是web层。

A主要是核心业务的代码实现，而B用于向外提供http服务和连接A项目。这两个项目都有spring，这时候我们一般是会将A打包成jar，然后供B调用。但这时候问题来了，B怎么才能同时接管A的spring呢

这时候会用到spring配置文件中的<import>标签，将jar包中的spring配置文件引入到B中。

```java
<import resource="classpath*:/spring/spring-common.xml" />
<import resource="classpath*:/spring/spring-mybatis.xml" />
<import resource="classpath*:/spring/spring-jms.xml" />
```



#### spring扫描

以前是认为只要配置了下面这个注解，那么spring就会自动去扫描该base-package，并且自动将里面所有的类纳入spring容器管理中，但是最近在做一个spring-cache的东西的时候，发现这个注解只是会起到标记扫描的作用，还是要自己去加注解让spring识别。

```xml
<context:component-scan base-package="com.navalon.superdemo.annotation"/>
```

> component-scan标签默认情况下自动扫描指定路径下的包（含所有子包），将带有@Component、@Repository、@Service、@Controller标签的类自动注册到spring容器。对标记了 Spring's @Required、@Autowired、JSR250's @PostConstruct、@PreDestroy、@Resource、JAX-WS's @WebServiceRef、EJB3's @EJB、JPA's @PersistenceContext、@PersistenceUnit等注解的类进行对应的操作使注解生效（包含了annotation-config标签的作用）。



#### 开启aop

```xml
<aop:aspectj-autoproxy /> 
```


#### Spring-test

若想执行测试用例的时候回滚，则在测试用例的头部加入

```
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
```



### Spring加载顺序比静态类加载慢的问题

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