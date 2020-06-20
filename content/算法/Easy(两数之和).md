---
title: (Easy)两数之和
date: 2020-01-27 11:56:15
collection: 数组
---

```txt
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
```

自己题解:

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        for (int i=0; i<nums.length; i++){
            for (int j=i+1; j<nums.length; j++){
                if (nums[i] + nums[j] == target) {
                    int[] array = new int[2];
                    array[0] = i;
                    array[1] = j;
                    return array;
                }
            }
        }

        return new int[0];
    }
}
```

2020-06-20 hash优化

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i=0; i<nums.length; i++) {
            map.put(nums[i], i);
        }

        int[] ret = new int[2];
        for (int i=0; i<nums.length; i++) {
            int diff = target - nums[i];
            Integer index = map.get(diff);
            if (index == null || index == i) {
                continue;
            }
            ret[0] = i;
            ret[1] = index;
        }

        return ret;
    }
}
```

分析:

1.简单的暴力破解
2.优化方向为利用hash表来加快匹配效率，将效率从n²降到n，但是题目必须加一个约束，不能出现相同数字