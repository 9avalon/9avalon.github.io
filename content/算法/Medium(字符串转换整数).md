---
title: (Medium)字符串转换整数
date: 2020-02-03 23:14:10
collection: 字符串
---

```txt
请你来实现一个 atoi 函数，使其能将字符串转换成整数。

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0。

说明：

假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。如果数值超过这个范围，请返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。

示例 1:

输入: "42"
输出: 42
示例 2:

输入: "   -42"
输出: -42
解释: 第一个非空白字符为 '-', 它是一个负号。
     我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
示例 3:

输入: "4193 with words"
输出: 4193
解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。
示例 4:

输入: "words and 987"
输出: 0
解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
     因此无法执行有效的转换。
示例 5:

输入: "-91283472332"
输出: -2147483648
解释: 数字 "-91283472332" 超过 32 位有符号整数范围。 
     因此返回 INT_MIN (−231) 。
```

自己题解:

```java
class Solution {
    public int myAtoi(String str) {
        int ret = 0;
        int lessZero = 0;
        boolean start = false;
        for (int i=0; i<str.length(); i++) {
            if (str.charAt(i) >= '0' && str.charAt(i) <= '9' ) {
                start = true;
                if (ret > Integer.MAX_VALUE / 10 
                    || (ret == Integer.MAX_VALUE / 10 && str.charAt(i)-48 > 7)) {
                    return Integer.MAX_VALUE;
                } else if (ret < Integer.MIN_VALUE / 10 
                           || (ret == Integer.MIN_VALUE / 10 && str.charAt(i)-48 > 8)) {
                    return Integer.MIN_VALUE;
                }
                ret = ret >= 0 ? ret * 10 + str.charAt(i) -48 : ret * 10 - (str.charAt(i)-48);
                if (lessZero == 1 && ret > 0) {
                    ret = -ret;    
                    lessZero = 0;
                }
            } else if (str.charAt(i) == '-' && start == false) {
                lessZero = 1;
                start = true;
            } else if (str.charAt(i) == ' ' && start == false) {
                continue;
            } else if (str.charAt(i) == '+' && start == false) {
                start = true;
                continue;
            } else {
                return ret;
            }

        }
        return ret;
    }
}
```

二刷，fail了两次，代码有点冗余，但是逻辑应该是比较清晰的。

```java
class Solution {
    public int myAtoi(String str) {
        boolean plus = true;
        boolean start = false;
        int ret = 0;
        for (int i=0; i<str.length(); i++) {
            // 处理负号
            if (str.charAt(i) == '-') {
                if (start) {
                    return plus ? ret : -ret;
                } else {
                    plus = false;
                    start = true;
                    continue;
                }
            }

            // 处理正号
            if (str.charAt(i) == '+') {
                if (start) {
                    return plus ? ret : -ret;
                } else {
                    start = true;
                    continue;
                }
            }

            // 处理空格
            if (str.charAt(i) == ' ') {
                if (!start) {
                    continue;
                } else {
                    return plus ? ret : -ret;
                }
            }

            // 处理非数字字符
            if (str.charAt(i) < '0' || str.charAt(i) > '9') {
                if (start) {
                    return plus ? ret : -ret;
                } else {
                    return 0;
                }
            } 

            start = true;

            // 处理数字
            int num = str.charAt(i) - '0';
            // 防溢出
            if (plus) {
                // 正数
                if ((ret > Integer.MAX_VALUE / 10) || ((ret * 10 == Integer.MAX_VALUE - 7) && num > 7)) {
                    return Integer.MAX_VALUE;
                }
            } else {
                // 负数
                if ((-ret < Integer.MIN_VALUE / 10) || ((-ret * 10 == Integer.MIN_VALUE + 8) && num > 8)) {
                    return Integer.MIN_VALUE;
                }
            }
            ret = ret*10 + num;
        }
        return plus ? ret : -ret;
    }
}
```

分析:

1. 苦力题，各种异常情况的判断。

2020-07-18 10:41:48, 二刷：其实挺好的一道题，不考验智力，考验编程功底。
