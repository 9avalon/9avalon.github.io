---
title: (Medium)跳跃游戏
date: 2020-06-21 16:52:31
collection: 贪心
---

```txt
给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

判断你是否能够到达最后一个位置。

示例 1:

输入: [2,3,1,1,4]
输出: true
解释: 我们可以先跳 1 步，从位置 0 到达 位置 1, 然后再从位置 1 跳 3 步到达最后一个位置。
示例 2:

输入: [3,2,1,0,4]
输出: false
解释: 无论怎样，你总会到达索引为 3 的位置。但该位置的最大跳跃长度是 0 ， 所以你永远不可能到达最后一个位置。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/jump-game
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

第一版，朴素的跳跃，最后一个用例直接超时。

```java
class Solution {
    public boolean canJump(int[] nums) {
        // start 16:25-16:52
        return jump(nums, 0);
    }

    private boolean jump(int[] nums, int index) {
        int maxStep = nums[index];
        if (index + maxStep >= nums.length - 1) {
            return true;
        }

        if (nums[index] == 0) {
            return false;
        }

        for (int i=index+maxStep; i>=index+1; i--) {
            boolean ret = jump(nums, i);   
            if (ret) {
                return ret;
            }
        }

        return false;
    }
}
```

第二版，看了题解，贪心前进，想象成能量格跳跃

```java
class Solution {
    public boolean canJump(int[] nums) {
        // start 16:25-16:52
        int max = 0;
        for (int i=0; i<nums.length; i++) {
            max = Math.max(i+nums[i], max);
            if (max >= nums.length-1) {
                return true;
            }

            if (i == max) {
                return false;
            }
        }

        return false;
    }
}
```

分析: 第一版直接超时了，第二版是看了题解才写出来的，有点巧妙，平时还真的不太容易想到。
