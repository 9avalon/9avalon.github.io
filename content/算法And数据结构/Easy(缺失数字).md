---
title: (Easy*)缺失数字
date: 2020-03-05 00:42:11
collection: 数学
---

```txt
给定一个包含 0, 1, 2, ..., n 中 n 个数的序列，找出 0 .. n 中没有出现在序列中的那个数。

示例 1:

输入: [3,0,1]
输出: 2
示例 2:

输入: [9,6,4,2,3,5,7,0,1]
输出: 8
说明:
你的算法应具有线性时间复杂度。你能否仅使用额外常数空间来实现?
```

自己题解:

```java
class Solution {
    public int missingNumber(int[] nums) {
        int sum = 0;
        int sum2 = 0;
        for (int i=0; i<nums.length; i++) {
            sum += i;
            sum2 += nums[i];
        }
        sum += nums.length;

        return sum - sum2;
    }
}
```

分析: 数学法简单高效。
