---
title: spring mvc
date: 2016-6-24 16:43:41
collection: Java框架
---

[TOC]

### 搭建Spring MVC

- 准备jar包，其实Spring的包里面已经整合了springmvc，直接全部拷进去即可
- 创建web工程。
- 引入包
- 配置web.xml
```xml
  <servlet>
    <servlet-name>springmvc</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
          <param-name>contextConfigLocation</param-name>
          <!-- 在这里配置springmvc在src里面的位置  -->
          <param-value>classpath:config/spring/springmvc.xml</param-value>
      </init-param>
  </servlet>
  <servlet-mapping>
    <servlet-name>springmvc</servlet-name>
    <!--  restful风格 -->
    <url-pattern>/</url-pattern>
  </servlet-mapping>	
```
- 配置好之后，新建springmvc配置文件，一般我会在src的根目录下建立一个config文件夹，专门用来存放框架的配置文件。
```xml
<?xml version="1.0" encoding="UTF-8" ?>   
<beans xmlns="http://www.springframework.org/schema/beans"  
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
     xmlns:mvc="http://www.springframework.org/schema/mvc"
     xmlns:context="http://www.springframework.org/schema/context"  
     xsi:schemaLocation="http://www.springframework.org/schema/beans 
     http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
     http://www.springframework.org/schema/context 
     http://www.springframework.org/schema/context/spring-context-3.0.xsd
     http://www.springframework.org/schema/mvc
     http://www.springframework.org/schema/mvc/spring-mvc-3.1.xsd">   
  
  <!-- 组件扫描handler -->
  <context:component-scan base-package="org.daxiang.controller"></context:component-scan>	
  
  <!-- 使用mvc:annotation-driven代替上面注解适配和映射器 -->
  <mvc:annotation-driven></mvc:annotation-driven>
  
  <!-- 视图解析器 -->
  <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
  	<property name="prefix" value="/jsps/" />
  	<property name="suffix" value=".jsp" />
  </bean>
  
  <!-- 文件上传 -->
  <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
  	<!-- 设置上传文件的大小最多大小50mb -->
  	<property name="maxUploadSize">
  		<value>5242880</value>
  	</property>
  </bean>
  
  <!-- 静态资源解析 -->
  <mvc:resources location="/js/" mapping="/js/**" />
  <mvc:resources location="/css/" mapping="/css/**" />
  <mvc:resources location="/images/" mapping="/images/**" />
  <mvc:resources location="/fonts/" mapping="/fonts/**" />
</beans>

```
如果使用的是restful风格的api，则需要在spinrgmvc的配置文件中加上
    <mvc:default-servlet-handler/>
不加的话会导致首页跳转不到index.jsp。

### 上传文件的配置
第一步是要在springmvc的配置文件里面写上这个
```xml
<!-- 文件上传 -->
<bean id="multipartResolver"           class="org.springframework.web.multipart.commons.CommonsMultipartResolver ">
  <!-- 设置上传文件的大小最多大小50mb -->
  <property name="maxUploadSize">
    <value>5242880</value>
  </property>
</bean>
```

第二步是上传的表单form中，需要加入这个enctype="multipart/form-data"
```html
<form action="<c:url value='/test/upload'/>" method="post" enctype="multipart/form-data" >
```

第三步是后台的接收，关键在于接收的数组，如果多个同name的文件上传，文件就会放到这个数组里面，然后如果某个文件没有上传，也会以0字节的大小来占位
```java
/**
* 测试上传
* @return
*/
@RequestMapping("/upload")
public @ResponseBody String testupload(Model model,       @RequestParam("multipartFiles") MultipartFile[] multipartFiles){
  System.out.println(multipartFiles.length);
  return "";
}
```