---
title: tomcat异常信息
date: 2016-6-23 17:10:51
collection: JavaEE
draft: true

---
#### 原因
之前简爱项目部署的时候，tomcat有时候老是关不掉（应该是因为我的svn提交导致的错误），这时候需要强制把tomcat关掉，不然tomcat就永远启动不起来了。

#### 步骤如下
1、./shutdown.sh 关闭tomcat 
2、ps -ef|grep tomcat 查看是否还有tomcat进程在后台运行。如果有说明tomcat没有彻底关闭。 
3、可以通过kill -9 pid方式关闭 
4、重新第二步操作验证是否关闭。如果关闭ok执行第五步 
5、./startup.sh  重新启动即可。