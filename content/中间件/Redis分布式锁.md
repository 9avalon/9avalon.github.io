---
title: Redis分布式锁
date: 2019-05-09 14:42:39
collection: 缓存
---

## 简单实现

注：
1.Redis的服务自行注入。
2.单点Redis没问题，Redis集群需考虑使用RedLock优化。
3.如果单点Redis故障，为保障业务，分布式锁会失效。

```java
/**
 * 简单的分布式锁实现
 *
 * @author Miguel.hou
 * @version v1.0
 * @date 2018/11/21
 */
public class DistributedLock {

    private static final int DEFAULT_REDIS_KEY_EXPIRE_SECOND = 60;

    /**
     * 分布式锁
     *
     * 如果redis异常，为不影响业务，默认会返回成功，当无事发生
     * @return
     */
    public static boolean lock(String key) {
        return lock(key, DEFAULT_REDIS_KEY_EXPIRE_SECOND);
    }

    /**
     * 分布式锁
     *
     * 如果redis异常，为不影响业务，默认会返回成功，当无事发生
     * @return
     */
    public static boolean lock(String key, Integer expireSecond) {
        boolean ret;
        try {
            // 存入当前时间
            String currentTime = String.valueOf(System.currentTimeMillis());
            ret = RedisDataOperat.setNxAndExpire(key, currentTime, expireSecond);

            // 如果ret失败，判断当前锁是否已经超时，若锁已经超时，则将锁删除，这里不继续塞锁，而是返回原结果。
            if (!ret) {
                String keyInDB = RedisDataOperat.getStringFromJedis(key);
                if (StringUtils.isNotBlank(keyInDB)) {
                    Long redisTimes = Long.valueOf(keyInDB);
                    Long currentMills = System.currentTimeMillis();
                    Long diffMills = currentMills - (redisTimes + (expireSecond * 1000));
                    if (diffMills > 0) {
                        RedisDataOperat.delKeyFromJedis(key);
                    }
                }
            }
        } catch (Exception e) {
            ret = true;
            log.error("redis operator error ...... key={}", key, e);
        }
        return ret;
    }

    /**
     * 释放分布式锁
     *
     * 如果redis异常，为不影响业务，默认会返回成功，当无事发生
     * @return
     */
    public static boolean release(String key) {
        try {
            long effectRow = RedisDataOperat.delKeyFromJedis(key);
        } catch (Exception e) {
            log.error("redis delete key error ...... key={}", key, e);
            return false;
        }
        return true;
    }
}
```