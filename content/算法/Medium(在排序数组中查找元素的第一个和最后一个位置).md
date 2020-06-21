---
title: (Medium)在排序数组中查找元素的第一个和最后一个位置
date: 2020-06-21 11:28:26
collection: 二分搜索
---

```txt
```

自己题解:

```java
class Solution {
    public int[] searchRange(int[] nums, int target) {
        if (nums.length == 0) {
            return new int[]{-1, -1};
        }

        int[] ret = new int[]{-1, -1};
        ret[0] = findLeftTarget(nums, target, 0, nums.length-1);
        ret[1] = findRightTarget(nums, target, 0, nums.length-1);
        return ret;
    }

    private int findLeftTarget(int[] nums, int target, int start, int end) {
        if (start > end) {
            return -1;
        }
        if (start == end) {
            if (nums[start] == target) {
                return start;
            }
            return -1;
        }

        int mid = (start + end)/2; 

        if (nums[mid] < target) {
            return findLeftTarget(nums, target, mid + 1, end);
        } else {
            return findLeftTarget(nums, target, start, mid);
        }
    }

    private int findRightTarget(int[] nums, int target, int start, int end) {
        if (start > end) {
            return -1;
        }

        if (start == end) {
            if (nums[start] == target) {
                return start;
            }
            return -1;
        }

        int mid = (start + end + 1)/2; 

        // mid = 3 l=0,r=5
        // mid = 3 l=3,r=5
        // mid = 4 l=4,r=5
        // mid = 5 l=4,r=5
        if (nums[mid] <= target) {
            return findRightTarget(nums, target, mid, end);
        } else {
            return findRightTarget(nums, target, start, mid - 1);
        }
    }
}
```

分析: 变种的二分搜索，需要注意的是，mid的取值，是向左取还是向右取。

