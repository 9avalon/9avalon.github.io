---
title: Mock
date: 2020-05-16 14:20:21
---

[Mockito](https://juejin.im/post/5d103ef76fb9a07ef5624163)

## 通过反射，修改bean的mock对象

```java
  @Before
  public void setUp() throws Exception {
    // 使用反射将IOC容器注入的service的属性替换指定为mock的对象
    ReflectionTestUtils.setField(carService, "basicService", basicService);
    PowerMockito.when(this.basicService, "getCarType", anyLong()).thenReturn(Optional.empty());
  }
```
