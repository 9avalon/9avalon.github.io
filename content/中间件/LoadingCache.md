---
title : LoadingCache本地缓存
date : 2020-07-02 11:41:01
collection: 缓存
---

1. guava的工具类，支持key过期。线程安全

```java
    /**
     * 20200323.Miguel，configCache不支持value为null的值，所以使用该缓存的时候，一定要在配置表配置，否则就会抛异常报错了。
     */
    private LoadingCache<String, String> configCache = CacheBuilder.newBuilder().expireAfterWrite(CACHE_EXPIRE_SECONDS, TimeUnit.SECONDS).build(new CacheLoader<String, String>() {
        @Override
        public String load(String configName) throws Exception {
            return null;
        }
    });
```
