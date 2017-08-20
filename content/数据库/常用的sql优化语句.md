---
title: sql优化
date: 2016-6-24 21:43:29
---

[TOC]
总结了一下，优化sql的关键在于加索引，然后尽量让数据查询都能使用到索引，如乱使用like或者or会导致数据库不使用索引查询，然后查询速度当然就会慢很多了

####怎么给sql语句做优化呢？
#####给列加索引
首先，最常用的当然还是加索引，索引能明显的提高查询数据的速度。
#####避免在where字句中使用is null 或者 is not null
```sql
select * from table where uname is null;
```

在这种情况下，就算给uname设置了索引，查询分析器也不会去使用，因此效率会底下，一般做法是给定一个默认值从而不让数据为空。

#####避免在where字句中使用！=或者<>操作符
同上，此种写法索引也不会生效，但是对于<、 <=、 >=、 =、 >这些倒是会有效果。建议写法为用union all连接
```sql
select name from table where id < 0  
union all  
select name from table where id > 0 ;
 
```
#####避免在where字句中使用or来链接条件
```sql
select  * from table where col1=? or col2=?;
```
这种情况下我们可以写
```sql
select * from table where col1=?
union all 
select * from table where col2=?;
```

#####少用 in或者not in
in和not in我在hql中用得很多。

其实，使用in也是会走索引，以下是摘自CSDN中别人的测试sql。

```sql
-- 建测试表
create table wzp144650
(id int, 
 de char(5000),
 wz varchar(10)
 constraint pk_wzp144650 primary key(id)
 )
 
-- 插入10万笔wz='144650'的记录
set nocount on
declare @x int=1
while(@x<=100000)
begin
  insert into wzp144650
    select @x,'abc','144650'
  select @x=@x+1
end
 
-- 插入1笔wz='6'的记录
insert into wzp144650 select 140001,'abc','6'
 
-- 在wz列上建索引
create index ix_wzp144650_wz on wzp144650(wz)
 
 
----- 测试 -----
 
-- 当where wz in ('6')时,能用索引.
select * from wzp144650 where wz in ('6')
--> Index Seek(OBJECT:([DBAP].[dbo].[wzp144650].[ix_wzp144650_wz]) 
-- CPU time = 0 ms,  elapsed time = 26 ms.
 
 
-- 当where wz in ('144650')时,不能用索引.
select * from wzp144650 where wz in ('144650')
--> Clustered Index Scan(OBJECT:([DBAP].[dbo].[wzp144650].[pk_wzp144650])
-- CPU time = 1294 ms,  elapsed time = 12507 ms.
```

可以看到，如果数据在表中是存在的，则会走索引，但是如果 要查找的数据不在表中的时候，就不能用索引了。

所以这时候要去衡量，若查找的数据几乎都在表里面，那用in是没问题的，如果1000条数据里面，只有1条在数据库里面是有的，则要考虑用另一种方式去优化了。

```sql
select * from table where col1 in (sql);
```
此外也这时候可以考虑用between来替代(对于已知)
```sql
select * from table where col1 between ? and ?
```

#####注意like通配符的使用
```java
//下面两种都会很慢，因为前面是通配符
select * from table where name like='%happy%'  
select * from table where name like='%happy'

//这种会快很多，因为使用到了索引
select * from table where name like='happy%'
```








