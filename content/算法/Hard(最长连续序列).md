---
title: (Hard*)最长连续序列
date: 2020-04-01 23:23:02
collection: Set
---

```txt
给定一个未排序的整数数组，找出最长连续序列的长度。

要求算法的时间复杂度为 O(n)。

示例:

输入: [100, 4, 200, 1, 3, 2]
输出: 4
解释: 最长连续序列是 [1, 2, 3, 4]。它的长度为 4。
```

自己题解:

```java
class Solution {
    public int longestConsecutive(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int i=0; i<nums.length; i++) {
            set.add(nums[i]);
        }

        int longest = 0;
        for (Integer num : set) {
            if (!set.contains(num - 1)) {
                int curr = 0;
                int temp = num;
                while (set.contains(temp)) {
                    curr ++;
                    temp ++;
                }
                longest = Math.max(longest, curr);
            }
        }

        return longest;
    }
}
```

分析: 这题其实还是有了技巧，没技巧的话，就只能排序，然后做处理了。
