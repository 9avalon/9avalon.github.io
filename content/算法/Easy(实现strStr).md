---
title: (Easy)实现strStr
date: 2020-02-08 12:54:25
collection: 字符串
---

```txt
实现 strStr() 函数。

给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。

示例 1:

输入: haystack = "hello", needle = "ll"
输出: 2
示例 2:

输入: haystack = "aaaaa", needle = "bba"
输出: -1
说明:

当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。

对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与C语言的 strstr() 以及 Java的 indexOf() 定义相符。
```

自己题解:

```java
class Solution {
    public int strStr(String haystack, String needle) {
        if (needle.length() == 0) {
            return 0;
        }

        int[] next = getNext(needle);
        int i=0;
        int j=0;
        while (i<haystack.length() && j<needle.length()){
            if (j==-1 || haystack.charAt(i) == needle.charAt(j)) {
                i++;
                j++;
            } else {
                j = next[j];
            }
        }

        if (j == needle.length()) {
            return i-j;
        } else {
            return -1;
        }
    }
    
    public int[] getNext(String needle) {
        int[] next = new int[needle.length()];
        next[0] = -1;
        int j = 0;
        int k = -1;
        while (j < needle.length() -1) {
            if (k == -1 || needle.charAt(k) == needle.charAt(j)) {
                k++;
                j++;
                next[j] = k;
            } else {
                k = next[k];
            }
        }
        return next;
    }
}
```

分析:

1. 看了题解，其实这题本意应该是用暴力循环法。不然也不会归类到Easy

2. 顺便复习了一下KMP算法。

3. KMP学习的blog [KMP](https://blog.csdn.net/v_july_v/article/details/7041827)
