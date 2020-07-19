---
title: (Medium)搜索旋转排序数组
date: 2020-06-21 01:51:57
collection: 二分查找
---

```txt
假设按照升序排序的数组在预先未知的某个点上进行了旋转。

( 例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] )。

搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。

你可以假设数组中不存在重复的元素。

你的算法时间复杂度必须是 O(log n) 级别。

示例 1:

输入: nums = [4,5,6,7,0,1,2], target = 0
输出: 4
示例 2:

输入: nums = [4,5,6,7,0,1,2], target = 3
输出: -1

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/search-in-rotated-sorted-array
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public int search(int[] nums, int target) {
        return search(nums, target, 0, nums.length - 1);
    }

    private int search(int[] nums, int target, int start, int end) {
        if (start > end) {
            return -1;
        }

        int mid = (end + start) / 2;
        if (nums[mid] == target) {
            return mid;
        }

        if (nums[end] > nums[mid]) {
            // 单调上升
            if (target <= nums[end] && target > nums[mid]) {
                // 右边
                return search(nums, target, mid + 1, end);
            } else {
                // 左边
                return search(nums, target, start, mid - 1);
            }
        } else {
            // 单调递减
            if (target > nums[end] && target < nums[mid]) {
                // 左边查找
                return search(nums, target, start, mid - 1);
            } else {
                // 右边查找
                return search(nums, target, mid + 1, end);
            }
        }
    }
}
```

分析: 要画图分析各种情况。
