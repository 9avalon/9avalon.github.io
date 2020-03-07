---
title: (Easy)验证回文字符串
date: 2020-02-01 23:33:03
collection: 字符串
---

```txt
给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。

说明：本题中，我们将空字符串定义为有效的回文串。

示例 1:

输入: "A man, a plan, a canal: Panama"
输出: true

示例 2:

输入: "race a car"
输出: false
```

自己题解:

```java
class Solution {
    public boolean isPalindrome(String s) {
        s = s.toLowerCase();
        int i=0;
        int j=s.length()-1;
        while (i < j) {
            if (!((s.charAt(i) >= 'a' && s.charAt(i) <= 'z') || (s.charAt(i) >= '0' && s.charAt(i) <= '9'))) {
                i++;
                continue;
            }
            if (!((s.charAt(j) >= 'a' && s.charAt(j) <= 'z') || (s.charAt(j) >= '0' && s.charAt(j) <= '9'))) {
                j--;
                continue;
            }
            if (s.charAt(i) != s.charAt(j)) {
                return false;
            }

            i++;
            j--;
        }
        return true;
    }
}
```

分析:

1.略，比较简单，用了库函数帮助大写转小写。
