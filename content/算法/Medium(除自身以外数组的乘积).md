---
title: (Medium*)除自身以外数组的乘积
date: 2020-03-08 15:53:12
collection: 字符串
---

```txt
给你一个长度为 n 的整数数组 nums，其中 n > 1，返回输出数组 output ，其中 output[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积。

 

示例:

输入: [1,2,3,4]
输出: [24,12,8,6]
 

提示：题目数据保证数组之中任意元素的全部前缀元素和后缀（甚至是整个数组）的乘积都在 32 位整数范围内。

说明: 请不要使用除法，且在 O(n) 时间复杂度内完成此题。

进阶：
你可以在常数空间复杂度内完成这个题目吗？（ 出于对空间复杂度分析的目的，输出数组不被视为额外空间。）
```

自己题解:

```java
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int[] left = new int[nums.length];
        int[] right = new int[nums.length];

        int leftMulti = 1;

        for (int i=0; i<nums.length; i++) {
            if (i == 0) {
                left[i] = 1;
                continue;
            }
            left[i] =  leftMulti * nums[i-1];
            leftMulti = left[i];
        }

        int rightMulti = 1;
        for (int i=nums.length-1; i>=0; i--) {
            if (i == nums.length - 1) {
                right[i] = 1;
                continue;
            }

            right[i] =  rightMulti * nums[i+1];
            rightMulti = right[i];
        }

        for (int i=0; i<nums.length; i++) {
            nums[i] = left[i] * right[i];
        }

        return nums;
    }
}
```

分析: 最容易想到的办法已经被题目限制住了，这题先遍历两次，生成数字左右两边的乘积，最后再遍历一次将左右乘积相乘就ok。
