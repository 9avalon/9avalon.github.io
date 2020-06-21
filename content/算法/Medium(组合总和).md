---
title: (Medium)组合总和
date: 2020-06-21 12:03:12
collection: 贪心
---

2020-06-21 12:03:59 AC时间18分钟

```txt
给定一个无重复元素的数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。

candidates 中的数字可以无限制重复被选取。

说明：

所有数字（包括 target）都是正整数。
解集不能包含重复的组合。 
示例 1:

输入: candidates = [2,3,6,7], target = 7,
所求解集为:
[
  [7],
  [2,2,3]
]
示例 2:

输入: candidates = [2,3,5], target = 8,
所求解集为:
[
  [2,2,2,2],
  [2,3,3],
  [3,5]
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/combination-sum
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> ret = new ArrayList<>();

        if (candidates.length == 0) {
            return ret;
        }

        Arrays.sort(candidates);
        find(candidates, target, 0, 0, new ArrayList<>(), ret);
        return ret;
    }

    private void find(int[] nums, int target, int cur, int index, List<Integer> list, List<List<Integer>> ret) {
        for (int i=index; i<nums.length; i++) {
            int sum = cur + nums[i];
            if (sum == target) {
                list.add(nums[i]);

                List<Integer> newList = new ArrayList<>();
                newList.addAll(list);
                ret.add(newList);

                list.remove(list.size()-1);
                break;
            } else if ( sum < target) {
                list.add(nums[i]);
                // 贪心，继续往下找
                find(nums, target, sum, i, list, ret);
                list.remove(list.size()-1);
            } else {
                break;
            }
        }
    }
}
```

分析: 贪心算法，排序剪枝

