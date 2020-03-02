---
title: (Easy)最大子序和
date: 2020-03-02 16:08:12
collection: 动态规划
---

```txt
给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

示例:

输入: [-2,1,-3,4,-1,2,1,-5,4],
输出: 6
解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
进阶:

如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。
```

自己题解:

```java
class Solution {
    public int maxSubArray(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }

        int currMax = nums[0];
        int max = nums[0];
        for (int i=1; i<nums.length; i++) {
            currMax = Math.max(nums[i], nums[i] + currMax);
            max = Math.max(currMax, max);
        }

        return max;
    }
}
```

分析: 这题看了题解，用贪心算法。
