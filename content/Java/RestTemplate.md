---
title: RestTempate
date: 2019-05-09 12:09:18
collection: Spring
---

这里会记录一些常用的http请求方法

## RestTemplate

### 最简单的用法

配置

```java
@Configuration
public class HttpConfiguration {

    @Bean(name = "restTemplate")
    RestTemplate restTemplate() {
        SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory();
        requestFactory.setConnectTimeout(5000);
        requestFactory.setReadTimeout(6000);

        return new RestTemplate(requestFactory);
    }
}
```

使用

```java
    @Resource(name = "restTemplate")
    private RestTemplate restTemplate;

    public BaseResp getWhiteListFromOPS() {
        MultiValueMap<String, String> request = new LinkedMultiValueMap<>();
        ResponseEntity<String> retEntity = restTemplate.postForEntity(url, request, String.class);
    }
```