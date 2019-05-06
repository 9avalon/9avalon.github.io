---
title: Maven
date: 2016-6-23 17:09:20
collection: 项目管理工具
---

[TOC]

## maven是什么

maven是一个项目管理和整合工具，其简化了工程的构建过程。并且提高了重用性。。。
当然maven给我最大的感受是处理jar包很方便，只需要把项目需要的包写到pom中，maven就会自动帮你把jar下载到仓库中，再也不用到苦逼地到处找包了。

## maven安装和下载

### 下载

[下载地址](http://maven.apache.org/download.cgi)

下载页面写到，需要注意的是maven3.3需要用到jdk1.7及以上。最近做的好多项目需要用到的最新jar包都已经不支持jdk1.6了，所以现在项目还是用1.7会比较好。

### 安装

设置Maven系统环境变量

    M2_HOME = D:\Program Files\apache-maven-3.0.5
添加Maven bin目录至系统环境变量PATH中

    %M2_HOME%\bin
(4)   确认Maven的安装

    cmd > mvn -version
   提示Maven version 3.0.5即安装成功。

### 创建工程

#### 命令行创建工程

创建命令:  

    mvn archetype:generate
第一次试的时候，被墙的太厉害了，maven的中央库连不上去。
然后网上找了一段仓库镜像。
使用方法：到maven的安装路径里面找conf，然后修改 setting文件。找到mirror，将下面这段代码加进去就可以了。
效果卓越！

**现在阿里云也搭建了一个maven开放仓库，简直造福国内java开发者啊！**

```xml
  <mirrors>
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
	<mirror>  
      <id>repo2</id>  
      <mirrorOf>central</mirrorOf>  
      <name>Human Readable Name for this Mirror.</name>  
      <url>http://repo2.maven.org/maven2/</url>  
	</mirror>  
	<mirror>  
		  <id>net-cn</id>  
		  <mirrorOf>central</mirrorOf>  
		  <name>Human Readable Name for this Mirror.</name>  
		  <url>http://maven.net.cn/content/groups/public/</url>   
	</mirror>  
	<mirror>  
		  <id>ui</id>  
		  <mirrorOf>central</mirrorOf>  
		  <name>Human Readable Name for this Mirror.</name>  
		 <url>http://uk.maven.org/maven2/</url>  
	</mirror>  
	<mirror>  
		  <id>ibiblio</id>  
		  <mirrorOf>central</mirrorOf>  
		  <name>Human Readable Name for this Mirror.</name>  
		 <url>http://mirrors.ibiblio.org/pub/mirrors/maven2/</url>  
	</mirror>  
	<mirror>  
		  <id>jboss-public-repository-group</id>  
		  <mirrorOf>central</mirrorOf>  
		  <name>JBoss Public Repository Group</name>  
		 <url>http://repository.jboss.org/nexus/content/groups/public</url>  
	</mirror>
  </mirrors>
```

#### myeclipse创建web工程。

需要配置好myeclipse的maven环境，具体的百度上很多。
new->other->maven project->（不要勾选create a simple project）next-> 选择maven-archetype-webapp

这种方法创建的工程会只有src/main/resource源文件夹，需要自己手动添加src/main/java,并且将这个文件夹的classes文件设置好。

### 常用命令

打包：mvn package

编译：mvn compile

编译测试程序：mvn test-compile

清空：mvn clean

运行测试：mvn test

生成站点目录: mvn site

生成站点目录并发布：mvn site-deploy

安装当前工程的输出文件到本地仓库: mvn install

工作中比较常用的是mvn clean install 这个命令，可以清空工程target文件然后重新编译生成。

### 参考阅读

[maven的那些事儿](“https://my.oschina.net/huangyong/blog/194583”)