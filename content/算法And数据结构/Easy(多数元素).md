---
title: (Easy)多数元素
date: 2020-03-05 13:10:06
collection: 字符串
---

```txt
给定一个大小为 n 的数组，找到其中的多数元素。多数元素是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。

你可以假设数组是非空的，并且给定的数组总是存在多数元素。

示例 1:

输入: [3,2,3]
输出: 3
示例 2:

输入: [2,2,1,1,1,2,2]
输出: 2
```

自己题解:

```java
class Solution {
    public int majorityElement(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i=0; i<nums.length; i++) {
            Integer sum = map.get(nums[i]);
            if (sum == null) {
                map.put(nums[i], 1);
            } else {
                map.put(nums[i], sum+1);
            }
        }

        for (Integer key : map.keySet()) {
            if (map.get(key) > nums.length/2) {
                return key;
            }
        }

        return 0;
    }
}
```

分析: 用哈希处理简单愉快
