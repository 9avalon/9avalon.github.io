---
title: (Medium)乘积最大子序列
date: 2020-03-08 13:50:46
collection: 字符串
---

```txt
给定一个整数数组 nums ，找出一个序列中乘积最大的连续子序列（该序列至少包含一个数）。

示例 1:

输入: [2,3,-2,4]
输出: 6
解释: 子数组 [2,3] 有最大乘积 6。
示例 2:

输入: [-2,0,-1]
输出: 0
解释: 结果不能为 2, 因为 [-2,-1] 不是子数组。
```

自己题解:

```java
class Solution {
    public int maxProduct(int[] nums) {
        if (nums.length == 1) {
            return nums[0];
        }

        int currMax = 1;
        int currMin = 1;
        int max = Integer.MIN_VALUE;
        for (int i=0; i<nums.length; i++) {
            if (nums[i] >= 0) {
                currMax = Math.max(currMax * nums[i], nums[i]);
                currMin = Math.min(currMin * nums[i], nums[i]);
            } else {
                int tempCurrentMin = Math.min(currMax * nums[i], nums[i]);
                currMax = Math.max(currMin * nums[i], nums[i]);
                currMin = tempCurrentMin;
            }

            max = Math.max(currMax, max);
        }

        return max;
    }
}
```

分析: 比最大子序和难一点，需要再保存一个最小值用来处理负数成负数成为最大的情况。
