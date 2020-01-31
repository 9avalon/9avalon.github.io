---
title: (Easy)有效的字母异位词
date: 2020-01-28 17:30:02
collection: 字符串
---

```txt
给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。

示例 1:

输入: s = "anagram", t = "nagaram"
输出: true
示例 2:

输入: s = "rat", t = "car"
输出: false
说明:
你可以假设字符串只包含小写字母。

进阶:
如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
案例:

s = "leetcode"
返回 0.

s = "loveleetcode",
返回 2.

注意事项：您可以假定该字符串只包含小写字母。
```

自己题解:

```java
class Solution {
    public boolean isAnagram(String s, String t) {
        Map<Character, Integer> map = new HashMap<>();
        for (int i=0; i<s.length(); i++) {
            Integer temp = map.get(s.charAt(i));
            if (temp == null) {
                map.put(s.charAt(i), 1);
            } else {
                map.put(s.charAt(i), temp+1);
            }
        }

        for (int i=0; i<t.length(); i++) {
            Integer temp = map.get(t.charAt(i));
            if (temp == null) {
                return false;
            }
            map.put(t.charAt(i), temp - 1);
        }

        for (Character key : map.keySet()) {
            if (map.get(key) != 0) {
                return false;
            }
        }

        return true;
    }
}
```

分析:

两个思路，第一是使用hash表，第二对两个数组进行排序，然后比对两个数组元素是否一致。
