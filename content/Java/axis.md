---
title : Axis
date : 2017-8-31 12:25
updated : 2017-8-31 12:25
collection : JavaSE
---

[TOC]

## axis

最近接的几家第三方机构都需要通过WebService来连接，所以会解除到这方面相关的知识

### 简介

**aixs**是开发WebService应用的利器，通过它，可以方便地发布服务或接收WebService请求。

一般WebService可以配合JAXB使用

### 使用

#### 引入相关pom包

```xml
        <dependency>
            <groupId>org.apache.axis</groupId>
            <artifactId>axis</artifactId>
            <version>1.4</version>
        </dependency>
        <dependency>
            <groupId>javax.xml</groupId>
            <artifactId>jaxrpc</artifactId>
            <version>1.1</version>
        </dependency>
        <dependency>
            <groupId>commons-discovery</groupId>
            <artifactId>commons-discovery</artifactId>
            <version>0.5</version>
        </dependency>
        <dependency>
            <groupId>wsdl4j</groupId>
            <artifactId>wsdl4j</artifactId>
            <version>1.6.2</version>
        </dependency>
```

#### 请求工具类

```java
/**
 * WebService请求客户端
 *
 * @author 侯铭健 2017-08-24
 */
public class AxisWebServiceClient {
    private static final Logger LOGGER = LoggerFactory.getLogger(AxisWebServiceClient.class);

    /**
     * 请求webservice
     */
    public static String axisCall(String method, String url, String requestXml) throws ServiceException, MalformedURLException, RemoteException {
        if (StringUtils.isEmpty(url)) {
            LOGGER.error("[AXIS]请求url为空");
            throw new NullPointerException("请求url为空");
        }
        LOGGER.info("[AXIS]请求报文:{}", requestXml);

        // 获取请求参数
        String returnStyle = "";
        String userName = "";
        String userPwd = "";

        Call call = (Call) service.createCall();
        // 访问地址
        call.setTargetEndpointAddress(new java.net.URL(url));
        // 要访问的方法名
        call.setOperationName(method);
        // 设置参数
        call.addParameter("userID", XMLType.XSD_STRING, ParameterMode.IN);
        call.addParameter("password", XMLType.XSD_STRING, ParameterMode.IN);
        call.addParameter("queryCondition", XMLType.XSD_STRING, ParameterMode.IN);
        call.addParameter("returnStyle", XMLType.XSD_STRING, ParameterMode.IN);

        call.setTimeout(PyCreditClientConstants.TIME_OUT);
        call.setReturnType(XMLType.XSD_STRING);

        String ret = (String) call.invoke(new Object[]{userName, userPwd, requestXml, returnStyle});

        LOGGER.info("[AXIS]返回报文:{}", ret);

        return ret;
    }
}
```

上述的方法，对应的是这样的一个webservice服务方法，`queryReport`为工具类传入的`method`参数

```java
String queryReport (String userID, String password, String queryCondition, String returnStyle) {

}
```

关于服务发布，等后面重新接触到，再进行笔记记录。
