---
title: (Medium)无重复字符的最长子串
date: 2020-06-18 02:08:32
collection: 字符串
---

```txt
给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

示例 1:

输入: "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
示例 2:

输入: "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
示例 3:

输入: "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
```

题解:

```java
class Solution {
    public int lengthOfLongestSubstring(String s) {
        if (s.length() == 0) {
            return 0;
        }
        
        if (s.length() == 1) {
            return 1;
        }
        
        int left = 0;
        int right = 0;
        int max =0;
        Map<Character, Integer> map = new HashMap<>();
        map.put(s.charAt(left), left);        
        
        while (++right < s.length()) {
            // 滑动窗口往右滑
            Character rightChar = s.charAt(right);
            Integer index = map.get(rightChar);
            if (index != null) {
                for (int i=left; i<=index; i++) {
                    map.remove(s.charAt(i));
                }
                left = index + 1;
            }
            map.put(s.charAt(right), right);

            max = right - left > max ? right - left : max; 
        }

        return max + 1;
    }
}
```

分析: 哎，一开始的思路是对的，用滑动窗口，但是没信息，后面看了题解才确定自己的思路是对的，然后写了下来。
