---
title: (Medium*)递增的三元子序列
date: 2020-03-08 13:50:46
collection: 字符串
---

```txt
给定一个未排序的数组，判断这个数组中是否存在长度为 3 的递增子序列。

数学表达式如下:

如果存在这样的 i, j, k,  且满足 0 ≤ i < j < k ≤ n-1，
使得 arr[i] < arr[j] < arr[k] ，返回 true ; 否则返回 false 。
说明: 要求算法的时间复杂度为 O(n)，空间复杂度为 O(1) 。

示例 1:

输入: [1,2,3,4,5]
输出: true
示例 2:

输入: [5,4,3,2,1]
输出: false
```

自己题解:

```java
class Solution {
    public boolean increasingTriplet(int[] nums) {
        if (nums.length < 3) {
            return false;
        }

        int min = Integer.MAX_VALUE;
        int mid = Integer.MAX_VALUE;

        for (int i=0; i<nums.length; i++) {
            if (nums[i] < min) {
                min = nums[i];
                continue;
            }

            if (nums[i] > min && nums[i] < mid) {
                mid = nums[i];
                continue;
            }

            if (nums[i] > mid) {
                return true;
            }
        }

        return false;
    }
}
```

分析: 想了15分钟没想出来思路，其实一开始的思路差不多，也是用一个min和mid来处理，但是想了下后觉得行不通这个想法就被放弃了。
