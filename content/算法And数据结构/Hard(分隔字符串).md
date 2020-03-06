---
title: (分隔字符串)分割回文串
date: 2020-03-07 00:12:10
collection: 字符串
---

```txt
给定一个字符串 s，将 s 分割成一些子串，使每个子串都是回文串。

返回 s 所有可能的分割方案。

示例:

输入: "aab"
输出:
[
  ["aa","b"],
  ["a","a","b"]
]
```

自己题解:

```java
class Solution {
    public List<List<String>> partition(String s) {
        List<List<String>> result = new ArrayList<>();
        dep(result, new ArrayList(), 0, s);
        return result;
    }

    private void dep(List<List<String>> result, List<String> list, int index, String s) {
        if (index >= s.length()) {
            result.add(new ArrayList(list));
            return;
        }

        StringBuilder sb = new StringBuilder();
        for (int i=index; i<s.length(); i++) {
            sb.append(s.charAt(i));
            // 校验是否回文串
            if (!isPartition(sb.toString())) {
                continue;
            }

            // 是回文串
            list.add(sb.toString());
            dep(result, list, i+1, s);
            list.remove(list.size()-1);
        }
    }

    private boolean isPartition(String s) {
        if (s.length() == 1) {
            return true;
        }

        int i=0;
        int j=s.length()-1;
        while (i < j) {
            if (s.charAt(i) == s.charAt(j)) {
                i++;
                j--;
                continue;
            } else {
                return false;
            }
        }

        return true;
    }
}
```

分析: 朴素的回溯法，再加判断回文串
