---
title: (Medium)摆动排序II
date: 2020-03-19 21:55:31
collection: 排序
---

```txt
给定一个无序的数组 nums，将它重新排列成 nums[0] < nums[1] > nums[2] < nums[3]... 的顺序。

示例 1:

输入: nums = [1, 5, 1, 1, 6, 4]
输出: 一个可能的答案是 [1, 4, 1, 5, 1, 6]
示例 2:

输入: nums = [1, 3, 2, 2, 3, 1]
输出: 一个可能的答案是 [2, 3, 1, 3, 1, 2]
说明:
你可以假设所有输入都会得到有效的结果。

进阶:
你能用 O(n) 时间复杂度和 / 或原地 O(1) 额外空间来实现吗？
```

题解:

```java
class Solution {
    public void wiggleSort(int[] nums) {
        if (nums.length == 0) {
            return;
        }

        Arrays.sort(nums);
        List<Integer> list = new ArrayList();
        for (int k=0; k<nums.length; k++) {
            list.add(nums[k]);
        }

        int size = nums.length;
        int mid = nums.length%2 == 0 ? nums.length/2 : (nums.length/2) + 1;

        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();
        for (int i=nums.length - 1; i>=0; i--) {
            if (i>= mid) {
                right.add(nums[i]);
            } else {
                left.add(nums[i]);
            }
        }

        // 错位插入
        int pos = 0;
        int i = 0;
        while (true) {
            if (pos >= left.size() && pos >= right.size()) {
                break;
            }
            if (pos < left.size()) {
                nums[i] = left.get(pos);
                i++;
            }
            if (pos < right.size()) {
                nums[i] = right.get(pos);
                i++;
            } 
            pos ++;
        }
    }
}
```

分析: 有点难纳，先排序，后倒序，间隔插入。
