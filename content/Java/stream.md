---
title: stream
date: 2020-03-20 11:53:21
collection: Java基础
---

1. List<Object> 转 List<Object.Id>

```java
List<String> skuIdList = goodsInfo.getGoodsDetail().stream().map(OrderCreateNotifyReqDTO.GoodsDetail::getGoodsId).collect(Collectors.toList());
```
