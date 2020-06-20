---
title: (Medium)下一个排列
date: 2020-06-20 22:25:35
collection: 字符串
---

```txt
实现获取下一个排列的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列。

如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。

必须原地修改，只允许使用额外常数空间。

以下是一些例子，输入位于左侧列，其相应输出位于右侧列。
1,2,3 → 1,3,2
3,2,1 → 1,2,3
1,1,5 → 1,5,1

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/next-permutation
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public void nextPermutation(int[] nums) {
        for (int i=nums.length-1; i>=0; i--) {
            if (i == 0) {
                Arrays.sort(nums);
                return;
            }

            int min = nums[i] - nums[i - 1];
            int target = i;
            if (nums[i] > nums[i-1]) {
                // 从k向后找，找到最小的数
                for (int k = i - 1; k < nums.length; k++) {
                    if (nums[k] <= nums[i-1]) {
                        continue;
                    }
                    if (nums[i-1] - nums[k] <= min) {
                        target = k;
                        min = nums[k];
                    }
                }

                // 交换
                int temp = nums[i - 1];
                nums[i - 1] = nums[target];
                nums[target] = temp;

                // 对交换元素后面的元素，做交换
                int left = i;
                int right = nums.length-1;;
                while (left < right) {
                    int t = nums[left];
                    nums[left] = nums[right];
                    nums[right] = t;
                    left ++;
                    right --;
                }
                return;
            }
        }
    }
}
```

分析: 有一说一，这题我觉得有点变态，主要是字符串的变化太多了，而且各种边界。

## 别人的题解

算法推导

如何得到这样的排列顺序？这是本文的重点。我们可以这样来分析：

我们希望下一个数比当前数大，这样才满足“下一个排列”的定义。因此只需要将后面的「大数」与前面的「小数」交换，就能得到一个更大的数。比如 123456，将 5 和 6 交换就能得到一个更大的数 123465。
我们还希望下一个数增加的幅度尽可能的小，这样才满足“下一个排列与当前排列紧邻“的要求。为了满足这个要求，我们需要：

在尽可能靠右的低位进行交换，需要从后向前查找

将一个 尽可能小的「大数」 与前面的「小数」交换。比如 123465，下一个排列应该把 5 和 4 交换而不是把 6 和 4 交换

将「大数」换到前面后，需要将「大数」后面的所有数重置为升序，升序排列就是最小的排列。以 123465 为例：首先按照上一步，交换 5 和 4，得到 123564；然后需要将 5 之后的数重置为升序，得到 123546。显然 123546 比 123564 更小，123546 就是 123465 的下一个排列

以上就是求“下一个排列”的分析过程。

作者：imageslr

链接：https://leetcode-cn.com/problems/next-permutation/solution/xia-yi-ge-pai-lie-suan-fa-xiang-jie-si-lu-tui-dao-/

来源：力扣（LeetCode）

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
