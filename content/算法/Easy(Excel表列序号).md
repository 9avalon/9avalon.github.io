---
title: (Easy)Excel表列序号
date: 2020-03-15 21:23:20
collection: 字符串
---

```txt
给定一个Excel表格中的列名称，返回其相应的列序号。

例如，

    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28 
    ...
示例 1:

输入: "A"
输出: 1
示例 2:

输入: "AB"
输出: 28
示例 3:

输入: "ZY"
输出: 701
致谢：
特别感谢 @ts 添加此问题并创建所有测试用例。
```

自己题解:

```java
class Solution {
    public int titleToNumber(String s) {
        int sum = 0;
        for (int i=0; i<s.length();  i++) {
            int temp = transfer(s.charAt(i));
            sum = sum * 26 + temp;
        }

        return sum;
    }

    private int transfer(Character c) {
        return c - 'A' + 1;
    }
}
```

分析: 哎，又刷了一题easy，为啥探索汇总里面会有easy题。
