---
title: (Easy)买卖股票的最佳时机
date: 2020-02-25 16:54:26
collection: 动态规划
---

```txt
给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

如果你最多只允许完成一笔交易（即买入和卖出一支股票），设计一个算法来计算你所能获取的最大利润。

注意你不能在买入股票前卖出股票。

示例 1:

输入: [7,1,5,3,6,4]
输出: 5
解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
示例 2:

输入: [7,6,4,3,1]
输出: 0
解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
```

自己题解:

第一版，时间复杂度 差不多n²

```java
class Solution {
    public int maxProfit(int[] prices) {
        int sumMax = 0;
        for (int i=0; i<prices.length; i++) {
            int buy = prices[i];
            int max = 0;
            for (int j=i+1; j<prices.length; j++) {
                if (prices[j] > max && prices[j] > prices[i]) {
                    max = prices[j];
                }
            }
            if (max - buy > sumMax) {
                sumMax = max - buy;
            }
        }
        return sumMax;
    }
}
```

看了评论区后，补充了一种dp思想的写法

```java
class Solution {
    public int maxProfit(int[] prices) {
        if (prices.length <=1) {
            return 0;
        }

        // 动态规划 前i天的最大收益 = max{前i-1天的最大收益，第i天的价格-前i-1天中的最小价格}

        int maxPrice = 0;
        int minPrice = prices[0];
        for (int i=1; i<prices.length; i++) {
            int diff = prices[i] - minPrice;
            if (diff > maxPrice && diff > 0) {
                maxPrice = diff;
            }
            if (prices[i] < minPrice) {
                minPrice = prices[i];
            }
        }

        return maxPrice;
    }
}
```
