---
title: (Easy)最长公共前缀
date: 2020-02-08 16:56:20
collection: 字符串
---

```txt
编写一个函数来查找字符串数组中的最长公共前缀。

如果不存在公共前缀，返回空字符串 ""。

示例 1:

输入: ["flower","flow","flight"]
输出: "fl"
示例 2:

输入: ["dog","racecar","car"]
输出: ""
解释: 输入不存在公共前缀。
说明:

所有输入只包含小写字母 a-z 。
```

自己题解:

```java
class Solution {
    public String longestCommonPrefix(String[] strs) {
        if (strs.length == 0) {
            return "";
        }

        int k=0;
        String prefix = "";
        while (true) {
            Character temp = null;
            for (int i=0; i<strs.length; i++) {
                // 超长
                if (k == strs[i].length()) {
                    return prefix;
                }

                if (temp == null) {
                    temp = strs[i].charAt(k);
                    continue;
                }

                if (strs[i].charAt(k) == temp) {
                    continue;
                } else {
                    return prefix;
                }
            }
            prefix += temp;
            k++;
        }
    }
}
```

分析: 比较简单，不花什么时间
