---
title: (Medium) 至少有K个重复字符的最长子串
date: 2020-06-20 15:56:44
collection: 字符串
---

```txt
找到给定字符串（由小写字符组成）中的最长子串 T ， 要求 T 中的每一字符出现次数都不少于 k 。输出 T 的长度。

示例 1:

输入:
s = "aaabb", k = 3

输出:
3

最长子串为 "aaa" ，其中 'a' 重复了 3 次。
示例 2:

输入:
s = "ababbc", k = 2

输出:
5

最长子串为 "ababb" ，其中 'a' 重复了 2 次， 'b' 重复了 3 次。
```

题解:

```java
class Solution {
    public int longestSubstring(String s, int k) {
        return check(s, 0, s.length()-1, k);
    }

    private int check(String s, int left, int right, int k) {
        if (right - left +1 < k) {
            return 0;
        }
        // 计算每一个字符串的出现次数
        HashMap<Character, Integer> map = new HashMap<>();
        for (int i=left; i<= right; i++) {
            Integer snum = map.get(s.charAt(i));
            if (snum == null) {
                map.put(s.charAt(i), 1);
            } else {
                map.put(s.charAt(i), snum + 1);
            }
        }

        while (right - left + 1 >= k && map.get(s.charAt(left)) < k) {
            left ++;
        }
        while (right - left + 1 >= k && map.get(s.charAt(right)) < k) {
            right --;
        }

        // 找出不符合条件的位置
        for (int i=left; i<= right; i++) {
            Integer count = map.get(s.charAt(i));
            if (count < k) {
                // 当前节点不满足条件，分冶左右边界
                int maxLeft = check(s, left, i-1, k);
                int maxRight = check(s, i+1, right, k);
                return Math.max(maxLeft, maxRight);
            }
        }

        return right - left + 1;
    }
}
```

分析: 这题本来是探索里面的动态规划题，但是看了题解，发现基本上都是用分冶法来做的，而且分冶法也比较简单好懂。

难点在于怎么优化算法才能不超时，后面是看了题解后发知道中间的两个while循环来缩减时间。
