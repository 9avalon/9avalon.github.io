---
title: (Hard)滑动窗口最大值
date: 2020-03-11 14:06:41
collection: 队列
---

```txt
给定一个数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。

返回滑动窗口中的最大值。

 

示例:

输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
输出: [3,3,5,5,6,7] 
解释: 

  滑动窗口的位置                最大值
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 

提示：

你可以假设 k 总是有效的，在输入数组不为空的情况下，1 ≤ k ≤ 输入数组的大小。

 

进阶：

你能在线性时间复杂度内解决此题吗？
```

题解:

```java
class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        if (nums == null || nums.length < 2){
            return nums;
        }

        int[] ret = new int[nums.length-k+1];
        LinkedList<Integer> queue = new LinkedList<>();
        for (int i=0; i<nums.length; i++) {
            while (queue.size() > 0 && nums[queue.getLast()] <= nums[i]) {
                queue.removeLast();
            }

            queue.addLast(i);

            if (queue.getFirst() <= i - k) {
                queue.removeFirst();
            }

            if (i - k + 1 >= 0) {
                ret[i-k+1] = nums[queue.getFirst()];
            }
        }

        return ret;
    }
}
```

分析: 思路是利用队列来维护队头的最大值
