---
title: JWT
date: 2019-10-23 22:53:18
collection: JavaSE
---

## 关于JWT的介绍

[JSON Web Token入门教程](http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)

## 实践

1.引入pom文件

```xml
<dependency>
    <groupId>com.auth0</groupId>
    <artifactId>java-jwt</artifactId>
    <version>2.2.0</version>
</dependency>
```

2.工具类

```java
/**
 * @author Miguel.hou
 * @version v1.0
 * @date 2019-10-10
 */
@Component
@Slf4j
public class JWTUtils {

    private static final String EXP = "exp";

    private static final String PAYLOAD = "payload";

    private static final String JWT_KEY = "j122kx91lzpefdjclkqj";

    /**
     * 加密，传入一个对象和有效期
     */
    public <T> String sign(T object) {
        try {
            final JWTSigner signer = new JWTSigner(JWT_KEY);
            final Map<String, Object> claims = new HashMap<String, Object>();
            ObjectMapper mapper = new ObjectMapper();
            String jsonString = mapper.writeValueAsString(object);
            claims.put(PAYLOAD, jsonString);
            // 过期时间单位是毫秒
            claims.put(EXP, System.currentTimeMillis() + (long) (1800 * 1000));
            return signer.sign(claims);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 解密，传入一个加密后的token字符串和解密后的类型
     * @param token
     * @param classT
     * @param <T>
     * @return
     */
    public <T> T unsign(String token, Class<T> classT) {
        final JWTVerifier verifier = new JWTVerifier(JWT_KEY);
        try {
            final Map<String, Object> claims = verifier.verify(token);
            if (claims.containsKey(EXP) && claims.containsKey(PAYLOAD)) {
                long exp = (Long) claims.get(EXP);
                long currentTimeMillis = System.currentTimeMillis();
                if (exp > currentTimeMillis) {
                    String json = (String) claims.get(PAYLOAD);
                    ObjectMapper objectMapper = new ObjectMapper();
                    return objectMapper.readValue(json, classT);
                }
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }
}
```
