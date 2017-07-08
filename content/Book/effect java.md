---
title : effect java
date : 2016-12-13 12:18:01
---



### 初始化类

1、JavaBean模式

2、构造方法

3、Builder方式

```java
OrderPO orderPO = OrderPOBuilder.orderId("").isDisplay("").getInstance();
```



### 枚举

枚举继承接口，实现每个枚举变量的方法，使得每个不同的枚举都有自己不同的方法调用。