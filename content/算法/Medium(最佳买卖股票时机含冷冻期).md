---
title: (Medium)最佳买卖股票时机含冷冻期
date: 2020-06-25 18:07:40
collection: 动态规划
---

```txt
给定一个整数数组，其中第 i 个元素代表了第 i 天的股票价格 。​

设计一个算法计算出最大利润。在满足以下约束条件下，你可以尽可能地完成更多的交易（多次买卖一支股票）:

你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
卖出股票后，你无法在第二天买入股票 (即冷冻期为 1 天)。
示例:

输入: [1,2,3,0,2]
输出: 3 
解释: 对应的交易状态为: [买入, 卖出, 冷冻期, 买入, 卖出]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public int maxProfit(int[] prices) {
        // 第几天持有 = Max(前一天持有，当天休息, 前一天卖，当天休息, 今天买)
        //dp[i][1] = Math.max(dp[i-1][1], dp[i-2][0] - prices[i]);
        // 第几天没持有 = Max(昨天持有，今天卖, 昨天没持有，今天也没买))
        //dp[i][0] = Math.max(dp[i-1][1] + prices, dp[i-1][0])
        if (prices.length <= 1) {
            return 0;
        }
        int[][] dp = new int[prices.length+1][2];
        dp[0][0] = 0;
        dp[0][1] = Integer.MIN_VALUE;
        dp[1][0] = 0;
        dp[1][1] = -prices[0];

        // 天数循环
        for (int i=2; i<=prices.length; i++) {
            // 买卖
            dp[i][0] = Math.max(dp[i-1][1] + prices[i-1], dp[i-1][0]);

            int dp_i_2_0 = 0;
            if (i - 2 >= 0) {
                dp_i_2_0 = dp[i-2][0] - prices[i-1];
            } else {
                dp_i_2_0 = Integer.MIN_VALUE;
            }
            dp[i][1] = Math.max(dp[i-1][1], dp_i_2_0);
        }


        return dp[prices.length][0];
    }
}
```

分析: 看了题解，买股票的万能公式？

