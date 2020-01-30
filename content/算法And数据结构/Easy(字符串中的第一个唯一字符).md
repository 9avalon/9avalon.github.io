---
title: (Easy)字符串中的第一个唯一字符
date: 2020-01-28 17:30:02
collection: 字符串
---

```txt
给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。

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
    public int firstUniqChar(String s) {
        Map<Character, Integer> map = new TreeMap<>();
        for (int i=0; i<s.length(); i++) {
            Integer tmp = map.get(s.charAt(i));
            if (tmp == null) {
                map.put(s.charAt(i), 1);
            } else {
                map.put(s.charAt(i), tmp+1);
            }
        }

        for (int i=0; i<s.length(); i++) {
            Integer tmp = map.get(s.charAt(i));
            if (tmp == 1) {
                return i;
            }
        }

        return -1;
    }
}
```

分析:

1.略，借助hashmap完成