---
title: (Medium)最长回文子串
date: 2020-06-19 13:07:12
collection: 字符串
---

```txt
给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

示例 1：

输入: "babad"
输出: "bab"
注意: "aba" 也是一个有效答案。
示例 2：

输入: "cbbd"
输出: "bb"
```

题解:

```java
class Solution {
    public String longestPalindrome(String s) {
        if (s.length() == 0) {
            return "";
        }

        int left = 0;
        int right = 0;
        int currMax = 0;

        boolean [][] dp = new boolean[s.length()][s.length()];
        for (int i=0; i<s.length(); i++) {
            dp[i][i] = true;
        }

        for (int j=1; j<s.length(); j++) {
            for (int i=0; i<j; i++) {
                if (s.charAt(i) != s.charAt(j)) {
                    dp[i][j] = false;
                    continue;
                }
                if (j-i == 1) {
                    dp[i][j] = true;
                } else {
                    dp[i][j] = dp[i+1][j-1];
                }

                if (dp[i][j] == true) {
                    if (j - i > currMax) {
                        currMax = j - i;
                        left = i;
                        right = j;
                    }
                }
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int i=left; i<=right; i++) {
            sb.append(s.charAt(i) + "");
        }

        return sb.toString();
    }
}
```

分析: 这题我觉得给hard一点也没问题，碰到这种题，最好是先暴力破解，然后再想办法优化。动态规划我感觉不容易想到，看了题解才想出来的。
