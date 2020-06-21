---
title: (Medium)子集
date: 2020-06-21 22:08:38
collection: 回溯法
---

```txt
给定一组不含重复元素的整数数组 nums，返回该数组所有可能的子集（幂集）。

说明：解集不能包含重复的子集。

示例:

输入: nums = [1,2,3]
输出:
[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/subsets
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<List<Integer>> subsets(int[] nums) {
        //start21:59 end 22:07
        List<List<Integer>> ret = new ArrayList<>();
        loop(nums, 0, new ArrayList<>(), ret);
        ret.add(new ArrayList<>());
        return ret;
    }

    private void loop(int[] nums, int index, List<Integer> temp, List<List<Integer>> ret) {
        for (int i=index; i<nums.length; i++) {
            temp.add(nums[i]);

            List<Integer> newList = new ArrayList<>();
            newList.addAll(temp);
            ret.add(newList);

            loop(nums, i + 1, temp, ret);

            temp.remove(temp.size() - 1);
        }
    }
}
```

分析: 这题有点简单，直接一个回溯法搞定。
