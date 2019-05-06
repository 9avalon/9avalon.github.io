---
title: Log4j
date: 2016-8-28 14:53
collection: JavaEE
---

# log4j

Log4j由三个重要的组件构成，分别为
1.loggers:负责采集日志信息
2.appenders:负责将日志发布到不同地方
3.layout:负责以各种风格格式化日志信息

## Logger对象



虽然说，现在一般都会使用slf4j来整合多个日志系统，但是个人开发的小项目中还是会用到log4j来记录日志，在这里就列一下自己常用的log4j配置文件

```properties
log4j.rootLogger=INFO,console,R,ERROR 
  
log4j.appender.console=org.apache.log4j.ConsoleAppender  
log4j.appender.console.threshold=INFO,ERROR 
log4j.appender.console.layout=org.apache.log4j.PatternLayout  
log4j.appender.console.layout.ConversionPattern=%d{yyyy-MM-dd HH\:mm\:ss} [%5p] - %c -%F(%L) -%m%n  
  
log4j.appender.R=org.apache.log4j.DailyRollingFileAppender 
log4j.appender.R.File=../dzdglogs/dzdg.log
log4j.appender.R.Encoding=UTF-8
log4j.appender.R.DatePattern = '.'yyyy-MM-dd 
log4j.appender.R.layout=org.apache.log4j.PatternLayout 
log4j.appender.R.layout.ConversionPattern=%-d{yyyy-MM-dd HH\:mm\:ss} [%c]-[%p] %m%n  
```

如果需要看debug信息，则在第一行中INFO前面添加DEBUG

在cosoloe.threshold中前面添加DEBUG，查看debug信息



