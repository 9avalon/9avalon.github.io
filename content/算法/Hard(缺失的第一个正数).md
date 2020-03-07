---
title: (Hard)缺失的第一个正数
date: 2020-02-08 12:54:25
collection: 字符串
---

```txt
给定一个未排序的整数数组，找出其中没有出现的最小的正整数。

示例 1:

输入: [1,2,0]
输出: 3
示例 2:

输入: [3,4,-1,1]
输出: 2
示例 3:

输入: [7,8,9,11,12]
输出: 1
说明:

你的算法的时间复杂度应为O(n)，并且只能使用常数级别的空间。
```

自己题解:

```java
class Solution {
    public int firstMissingPositive(int[] nums) {
        for (int i = 0; i<nums.length; i++) {
            if (nums[i] == i+1) {
                continue;
            }
            if (nums[i] >= 1 && nums[i] <= nums.length) {
                // 将交换nums[nums[i] - 1]
                // 要交换nums[i]
                int a = nums[i] - 1; //2
                int b = i;  //0
                if (nums[a] == nums[b]) {
                    continue;
                }
                int temp = nums[a];  // -1
                nums[a] = nums[b];
                nums[b] = temp;
                i--;
            }
        }

        for (int i=0; i<nums.length; i++) {
            if (nums[i] != i+1) {
                return i+1;
            }
        }
        return nums.length+1;
    }
}
```

分析:

1.参考了评论第一个答案去做的

>>遍历一次数组把大于等于1的和小于数组大小的值放到原数组对应位置，然后再遍历一次数组查当前下标是否和值对应，如果不对应那这个下标就是答案，否则遍历完都没出现那么答案就是数组长度加1。

第一坑是交换后，会导致部分数没遍历到，所以做了原地继续交换处理

第二坑是输入会有重复的数字，导致超时，加了条件过滤掉这种情况后就AC了。