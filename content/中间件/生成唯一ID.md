---
title: 分布式生成唯一ID
date: 2019-10-25 12:18:46
collection: 其他
---

需求：分布式环境下，生成唯一自增ID

参考了snowflake算法的生成自增序列方法

```java
/**
 * 线程安全的ID自增工具类，保证同一毫秒内，生成不重复，递增的ID
 *
 * @author Miguel.hou
 * @version v1.0
 * @date 2019-10-17
 */
public class TradeNoGenerateUtils {

    private long sequence; //序列号
    private long lastStamp;//上一次时间戳
    private int maxSequence; //最大的自增位数
    private int maxBit; // 最大位数

    public TradeNoGenerateUtils(int maxBit) {
        this.sequence = 0;
        this.lastStamp = -1L;
        this.maxBit = maxBit;

        if (maxBit <= 0) {
            throw new IllegalArgumentException("maxBit must greater than zero");
        }
        this.maxSequence = (int) Math.pow(10, maxBit);
    }

    /**
     * 不足位补零
     * @return
     */
    private String padding(long id) {
        StringBuilder sb = new StringBuilder();

        int paddingNum = maxBit - String.valueOf(id).length();
        for (int i = 0; i < paddingNum; i++) {
            sb.append("0");
        }
        sb.append(id);
        return sb.toString();
    }

    /**
     * 产生tradeNo
     * 
     * @param methodCode 方法代码
     * @param serverNo 机器号
     * @return
     */
    public synchronized String generateTradeNo(String methodCode, String serverNo) {
        long currStamp = getNewstmp();
        if (currStamp < lastStamp) {
            throw new RuntimeException("Clock moved backwards.  Refusing to generate id");
        }

        if (currStamp == lastStamp) {
            //相同毫秒内，序列号自增
            sequence = (sequence + 1) % maxSequence;
            //同一毫秒的序列数已经达到最大
            if (sequence == 0L) {
                currStamp = getNextMill();
            }
        } else {
            //不同毫秒内，序列号置为0
            sequence = 0L;
        }

        lastStamp = currStamp;

        String no = methodCode + DateUtil.parseTimeStamp(currStamp) + padding(sequence) + serverNo;
        return no + GeneralUtil.getLUHNCode(no);

    }

    private long getNextMill() {
        long mill = getNewstmp();
        while (mill <= lastStamp) {
            mill = getNewstmp();
        }
        return mill;
    }

    private long getNewstmp() {
        return System.currentTimeMillis();
    }

    public static void main(String[] args) {
        TradeNoGenerateUtils autoIncrIdUtils = new TradeNoGenerateUtils(3);
        for (int i = 0; i < (1 << 12); i++) {
            System.out.println(autoIncrIdUtils.generateTradeNo("1000", "0"));
        }
    }
}
```
