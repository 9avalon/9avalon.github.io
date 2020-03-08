---
title: (Medium)数组中的第K个最大元素
date: 2020-03-08 23:27:12
collection: 队列
---

```txt
在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。

示例 1:

输入: [3,2,1,5,6,4] 和 k = 2
输出: 5
示例 2:

输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
输出: 4
说明:

你可以假设 k 总是有效的，且 1 ≤ k ≤ 数组的长度。
```

自己题解:

```java
class Solution {
    public int findKthLargest(int[] nums, int k) {
        List<Integer> list = new ArrayList();
        for (int i=0; i<nums.length; i++) {
            list.add(nums[i]);
        }
        Collections.sort(list);
        return list.get(list.size() - k);
    }
}
```

分析: 这题其实我自己偷懒了，比较好的做法有两种，第一种是构造最小堆，第二种是参考快排的分冶

