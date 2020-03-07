---
title: (Easy*)合并两个有序数组
date: 2020-02-19 11:47:56
collection: 排序和搜索
---

```txt
给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。

说明:

初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
示例:

输入:
nums1 = [1,2,3,0,0,0], m = 3
nums2 = [2,5,6],       n = 3

输出: [1,2,2,3,5,6]
```

自己题解:

```java
class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        int p1 = 0;
        int p2 = 0;
        int np = 0;
        int[] newNums = new int[m+n];
        while (p1 < m || p2 < n) {
            if (p1 >= m) {
                newNums[np] = nums2[p2];
                np ++;
                p2 ++;
                continue;
            }

            if (p2 >= n) {
                newNums[np] = nums1[p1];
                np ++;
                p1 ++;
                continue;
            }

            if (nums1[p1] <= nums2[p2]) {
                newNums[np] = nums1[p1];
                np ++;
                p1 ++;
            } else {
                newNums[np] = nums2[p2];
                np ++;
                p2 ++;
            }
        }

        for (int i=0; i<m+n; i++) {
            nums1[i] = newNums[i];
        }
    }
}
```

分析: 上面的题解是新增一个数组来存放有序的数据，空间复杂度为m+n，看了作业，最优的解法是从最后从大到小排序。
