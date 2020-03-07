---
title: (Hard*)单词拆分II
date: 2020-03-07 13:38:03
collection: 字符串
---

```txt
给定一个非空字符串 s 和一个包含非空单词列表的字典 wordDict，在字符串中增加空格来构建一个句子，使得句子中所有的单词都在词典中。返回所有这些可能的句子。

说明：

分隔时可以重复使用字典中的单词。
你可以假设字典中没有重复的单词。
示例 1：

输入:
s = "catsanddog"
wordDict = ["cat", "cats", "and", "sand", "dog"]
输出:
[
  "cats and dog",
  "cat sand dog"
]
示例 2：

输入:
s = "pineapplepenapple"
wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
输出:
[
  "pine apple pen apple",
  "pineapple pen apple",
  "pine applepen apple"
]
解释: 注意你可以重复使用字典中的单词。
示例 3：

输入:
s = "catsandog"
wordDict = ["cats", "dog", "sand", "and", "cat"]
输出:
[]
```

自己题解:

```java
class Solution {

    HashMap<Integer, List<String>> map = new HashMap<>();

    public List<String> wordBreak(String s, List<String> wordDict) {
        return check(s, 0, wordDict);
    }

    private List<String> check(String s, Integer start, List<String> wordDict) {
        if (map.get(start) != null) {
            return map.get(start);
        }

        List<String> res = new ArrayList<>();
        if (start == s.length()) {
            res.add("");
            return res;
        }

        for (int end = start + 1; end <= s.length(); end ++) {
            String sb = s.substring(start, end);
            if (wordDict.contains(sb)) {
                List<String> checkList = check(s, end, wordDict);
                for (int i=0; i<checkList.size(); i++) {
                    res.add(sb + (Objects.equals(checkList.get(i), "") ? "" : " ") + checkList.get(i)); 
                }
            }
        }

        map.put(start, res);
        return res;
    }
}
```

分析: 单词拆分的变种题，写出来还是很花时间。
