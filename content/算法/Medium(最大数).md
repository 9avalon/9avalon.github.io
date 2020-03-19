---
title: (Medium)最大数
date: 2020-03-19 18:34:26
collection: 排序
---

```txt
给定一组非负整数，重新排列它们的顺序使之组成一个最大的整数。

示例 1:

输入: [10,2]
输出: 210
示例 2:

输入: [3,30,34,5,9]
输出: 9534330
说明: 输出结果可能非常大，所以你需要返回一个字符串而不是整数。
```

题解:

```java
class Solution {
    public String largestNumber(int[] nums) {
        // 排序，从大到小
        quickSort(nums, 0, nums.length - 1);
        // 打印
        StringBuilder sb = new StringBuilder();
        for (int n : nums) {
            if (sb.length() == 1 && sb.toString().equals("0") && n == 0) {
                continue;
            }
            sb.append(n);
        }
        return sb.toString();
    }

    private void quickSort(int[] nums, int start, int end) {
        if (start > end) {
            return;
        }

        int left = start;
        int right = end;
        int temp = nums[left];

        while (left != right) {
            // 右边节点走
            while (compare(nums[right], temp) <= 0 && left < right) {
                right --;
            }
            // 左边节点走
            while (compare(nums[left], temp) >= 0 && left < right) {
                left ++;
            }
            // 左右交换
            if (left < right) {
                int t = nums[left];
                nums[left] = nums[right];
                nums[right] = t;
            }
        }

        // 最终将基准数归位
        nums[start] = nums[left];
        nums[left] = temp;

        // 左右递归继续排序
        quickSort(nums, start, left - 1);
        quickSort(nums, left + 1, end);
    }

    // left>right 1
    // left=right 0
    // left<right -1
    private Integer compare(int left, int right) {
        String leftStr = String.valueOf(left);
        String rightStr = String.valueOf(right);

        Long sum1 = Long.valueOf(leftStr + rightStr);
        Long sum2 = Long.valueOf(rightStr + leftStr);
        if (sum1 > sum2) {
            return 1;
        } else if (Objects.equals(sum1, sum2)) {
            return 0;
        } else {
            return -1;
        }
//        int i = 0;
//        while (true) {
//            if (i >= leftStr.length() && i >= rightStr.length()) {
//                return 0;
//            }
//            if (i >= leftStr.length()) {
//                return -1;
//            }
//            if (i >= rightStr.length()) {
//                return 1;
//            }
//
//            int ret = leftStr.charAt(i) - rightStr.charAt(i);
//            if (ret > 0) {
//                return 1;
//            } else if (ret < 0){
//                return -1;
//            }
//
//            i++;
//        }
    }
}
```

分析:

1.核心是快排，并且修改快排的比较大小逻辑

2.一开始想岔了，比较大小的逻辑写得很复杂（注释那里），后面看了题解改了策略。