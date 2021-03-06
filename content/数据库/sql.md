---
title: sql语句记录
date: 2016-9-6 22:50:40
---

# 收录工作中常用的sql

[TOC]

## 函数

###  CONCAT——连接字符串

```sql
select * from table where t1 = CONCAT(str1, str2, ......)
```

### DATE_FORMAT——字符串转日期

```sql
select * from table where t1 = DATE_FORMAT(now(), `%Y-%m-%d`)

%Y：年
%c：月
%d：日
%H：小时
%i：分钟
%s：秒
```

 还有很多扩展的写法，如小写的y是两位数的年份等等。

##### DATE_ADD ——增加日期

```sql
select DATE_ADD(now(),INTERVAL 2 DAY)   // 增加两天的时间
```

##### DATE_SUB —— 减少日期

```sql
select DATE_SUB(now(),INTERVAL 2 HOUR) // 减少两个小时
```

### 查询重复

```sql
select order_id,count(*) as count from t_order group by order_id having count>1;
```

### 存储过程

1、传入参数是varchar类型时要注意，传入参数要带 '', 不然参数不能识别

#### SAVE OR UPDATE

```sql
INSERT INTO table (id, name, age) VALUES(1, "A", 19) ON DUPLICATE KEY UPDATE    
name="A", age=19
```

### 实际sql

A表，B表，C表，其中C与AB表为多对多关系，现在B表有一条记录缺失，需要找出该记录
```sql
select * from t_C tc INNER JOIN t_A ta ON tc.aId=ta.id where tc.bId not in (select * from t_b tb)
```

### 特殊字符转义

使用这个来避免特殊字符转义
```sql
<![CDATA[ sql  ]]]>
```
