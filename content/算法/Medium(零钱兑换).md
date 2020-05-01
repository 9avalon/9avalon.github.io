---
title: (Medium)零钱兑换
date: 2020-05-01 22:48:08
collection: 动态规划
---

```txt
给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。

 

示例 1:

输入: coins = [1, 2, 5], amount = 11
输出: 3 
解释: 11 = 5 + 5 + 1
示例 2:

输入: coins = [2], amount = 3
输出: -1
 

说明:
你可以认为每种硬币的数量是无限的。
```

题解:

```java
class Solution {

    public int coinChange(int[] coins, int amount) {
        if (amount == 0) {
            return 0;
        }

        int[] dp = new int[amount+1];

        for (int i=0; i<dp.length; i++) {
            dp[i] = Integer.MAX_VALUE;
        }

        for (int i=0; i<coins.length; i++) {
            if (coins[i] >= dp.length) {
                continue;
            }
            dp[coins[i]] = 1;
        }

        for (int i=1; i<=amount; i++) {
            if (dp[i] == 1) {
                continue;
            }
            int min = Integer.MAX_VALUE;
            for (int j=0; j<coins.length; j++) {
                if (i-coins[j] < 0) {
                    continue;
                }

                int dpLast = dp[i-coins[j]];
                if (dpLast != Integer.MAX_VALUE) {
                    dpLast += 1;
                }
                min = Math.min(dpLast, min);
            }
            dp[i] = min;
        }

        int ret = dp[dp.length-1];
        return ret == Integer.MAX_VALUE ?  -1 : ret;
    }
}
```

分析: 常规的动态规划题，比较容易想到
