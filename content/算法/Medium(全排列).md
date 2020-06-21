---
title: (Medium)全排列
date: 2020-06-21 12:21:31
collection: 回溯法
---

2020-06-21 12:22:09  //12:05开始 12:20分结束

```txt
给定一个 没有重复 数字的序列，返回其所有可能的全排列。

示例:

输入: [1,2,3]
输出:
[
  [1,2,3],
  [1,3,2],
  [2,1,3],
  [2,3,1],
  [3,1,2],
  [3,2,1]
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/permutations
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<List<Integer>> permute(int[] nums) {
        //12:05开始 12:20分结束
        List<List<Integer>> ret = new ArrayList<>();

        if (nums.length == 0) {
            return ret;
        }
        permuteOne(nums, new HashSet<>(), ret, new ArrayList<>());
        return ret;
    }

    private void permuteOne(int[] nums, Set<Integer> set, List<List<Integer>> ret, List<Integer> list) {
        for (int i=0; i<nums.length; i++) {
            if (set.contains(nums[i])) {
                continue;
            }

            // 结束
            if (list.size() + 1 == nums.length) {
                List<Integer> newList = new ArrayList<>();
                newList.addAll(list);
                newList.add(nums[i]);
                ret.add(newList);
                continue;
            }

            list.add(nums[i]);
            set.add(nums[i]);
            permuteOne(nums, set, ret, list);
            list.remove(list.size()-1);
            set.remove(nums[i]);
        }
    }
}
```

分析: 经典回溯

