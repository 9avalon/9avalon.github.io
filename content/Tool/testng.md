---
title : TestNG
date : 2016年10月20日11:03:30
collection: 常用
---

TestNG目前我应用到的情况是多线程的测试

首先引入pom文件

```xml
		<dependency>
			<groupId>org.testng</groupId>
			<artifactId>testng</artifactId>
			<version>6.9.10</version>
			<scope>test</scope>
		</dependency>
```

与spring集成，直接继承该类即可，这里@Test是testng的

```java
/**
 * TestNG 测试基类
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2016/10/19
 */
@ContextConfiguration(locations = { "classpath:spring/*.xml" })
@ActiveProfiles("devjunit")
public class SimpleNGTest extends AbstractTestNGSpringContextTests {

    /**
     * 例子
     * invocationCount 方法执行的次数， threadPoolSize 线程数
     * @throws Exception
     */
//    @Test(invocationCount = 20, threadPoolSize = 10)
//    public void testRun() throws Exception {
//    }
}
```



