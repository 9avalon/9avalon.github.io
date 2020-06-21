---
title: (Medium)字母异位词分组
date: 2020-06-21 13:01:51
collection: 字符串
---

```txt
给定一个字符串数组，将字母异位词组合在一起。字母异位词指字母相同，但排列不同的字符串。

示例:

输入: ["eat", "tea", "tan", "ate", "nat", "bat"]
输出:
[
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
]
说明：

所有输入均为小写字母。
不考虑答案输出的顺序。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/group-anagrams
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<List<String>> groupAnagrams(String[] strs) {
        //12:32start 13:02end 看了题解
        Map<String, List<String>> map = new HashMap<>();
        for (int i=0; i < strs.length; i++) {
            String s = strs[i];
            char[] chars = s.toCharArray();
            Arrays.sort(chars);
            String sortKey = new String(chars);

            List<String> mapValue = map.getOrDefault(sortKey, new ArrayList<>());
            mapValue.add(s);
            map.put(sortKey, mapValue);
        }

        List<List<String>> ret = new ArrayList<>();
        for (String key : map.keySet()) {
            ret.add(map.get(key));
        }
        return ret;
    }
}
```

分析: 大意了，忘记可以排序了，排序之后做起来简单了非常非常多
