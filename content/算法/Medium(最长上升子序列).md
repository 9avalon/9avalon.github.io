---
title: (Medium)最长上升子序列
date: 2020-05-01 21:57:31
collection: 动态规划
---

```txt
给定一个无序的整数数组，找到其中最长上升子序列的长度。

示例:

输入: [10,9,2,5,3,7,101,18]
输出: 4 
解释: 最长的上升子序列是 [2,3,7,101]，它的长度是 4。
说明:

可能会有多种最长上升子序列的组合，你只需要输出对应的长度即可。
你算法的时间复杂度应该为 O(n2) 。
进阶: 你能将算法的时间复杂度降低到 O(n log n) 吗?
```

题解:

```java
class Solution {
    public int lengthOfLIS(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }
        int[] dp = new int[nums.length];
        dp[0] = 1;
        int max = 1;
        for (int i=1; i<nums.length; i++) {
            int currMax = 0;
            for (int j=0; j<i; j++) {
                if (nums[i] > nums[j]) {
                    currMax = Math.max(dp[j], currMax);
                }

                dp[i] = currMax + 1;
                max = Math.max(dp[i], max);
            }
        }
        return max;
    }
}
```

分析: 后面看了题解后，发现自己想得太复杂了。。