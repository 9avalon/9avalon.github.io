---
title: (Hard*)跳跃游戏 II
date: 2020-07-19 11:05:34
collection: 字符串
---

```txt
给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

你的目标是使用最少的跳跃次数到达数组的最后一个位置。

示例:

输入: [2,3,1,1,4]
输出: 2
解释: 跳到最后一个位置的最小跳跃数是 2。
     从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
说明:

假设你总是可以到达数组的最后一个位置。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/jump-game-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

自己题解:

```java
class Solution {
    public int jump(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }
        int left = 0;
        int right = 0;
        int step = 0;
        while (right < nums.length - 1) {
            // 计算当前区间内能走到的最大值
            int max = 0;
            int index = left;
            for (int i=left; i<=right; i++) {
                if (i + nums[i] >= max) {
                    max = i + nums[i];
                    index = i;
                }
            }

            // 步数加一
            step++;

            // 重新设置行走范围
            left = index + 1;
            right = max;
        }

        return step;
    }
}
```

分析: 单词拆分的变种题，写出来还是很花时间。
