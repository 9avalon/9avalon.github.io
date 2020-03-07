---
title: (Medium)单词拆分
date: 2020-03-07 00:12:10
collection: 字符串
---

```txt
给定一个非空字符串 s 和一个包含非空单词列表的字典 wordDict，判定 s 是否可以被空格拆分为一个或多个在字典中出现的单词。

说明：

拆分时可以重复使用字典中的单词。
你可以假设字典中没有重复的单词。
示例 1：

输入: s = "leetcode", wordDict = ["leet", "code"]
输出: true
解释: 返回 true 因为 "leetcode" 可以被拆分成 "leet code"。
示例 2：

输入: s = "applepenapple", wordDict = ["apple", "pen"]
输出: true
解释: 返回 true 因为 "applepenapple" 可以被拆分成 "apple pen apple"。
     注意你可以重复使用字典中的单词。
示例 3：

输入: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
输出: false
```

自己题解:

第一次的做法，用字典递归判断是否符合，超时

```java
class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {
        return check(s, "", wordDict);
    }

    private boolean check(String s, String temp, List<String> wordDict) {
        if (Objects.equals(temp, s)) {
            return true;
        }

        for (int i=0; i< wordDict.size(); i++) {
            String checkTemp = temp + wordDict.get(i);
            if (checkTemp.length() > s.length() || !s.startsWith(checkTemp)) {
                continue;
            }

            boolean checkRet = check(s, checkTemp, wordDict);
            if (checkRet) {
                return true;
            }
        }

        return false;
    }
}
```

看了题解后，重写了一版，加了记忆化，复杂度降低到n²

```java
class Solution {
    public boolean wordBreak(String s, List<String> wordDict) {
        return check(s, 0, wordDict, new Boolean[s.length()]);
    }

    private boolean check(String s, int start, List<String> wordDict, Boolean[] records) {
        if (start == s.length()) {
            return true;
        }

        if (records[start] != null) {
            return records[start];
        }

        for (int end = start + 1; end <= s.length(); end ++) {
            String sb = s.substring(start, end);
            if (wordDict.contains(sb) && check(s, end, wordDict, records)) {
                records[start] = true;
                return true;
            }
        }

        records[start] = false;
        return false;
    }
}
```

分析: 有点难，后面能不能熟能生巧呢？
