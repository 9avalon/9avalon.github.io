---
title: (Easy)整数反转
date: 2020-01-27 11:56:15
collection: 字符串
---

```txt
给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

示例 1:

输入: 123
输出: 321
 示例 2:

输入: -123
输出: -321
示例 3:

输入: 120
输出: 21
注意:

假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231,  231 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。
```

自己题解:

```java
class Solution {
    public int reverse(int x) {
        boolean lessZero = x < 0;

        x = Math.abs(x);
        List<Integer> list = new ArrayList<>();

        boolean first = true;

        while (x > 0) {
          int yu =  x % 10;
          if (yu == 0 && first) {
              x = x / 10;
              continue;
          }
          list.add(yu);  
          x = x / 10;
          first = false;
        }

        int ret = 0;
        for (int i=0; i<list.size(); i++){
            ret += list.get(i) * Math.pow(10,list.size()-i-1);
            if (ret == 2147483647) {
                return 0;
            }
        }
        int result = lessZero ? -ret : ret;
        return result;
    }
}
```

分析:

上面自己的解法比较挫，后面看了一下题解区，发现想错了方向。改进后的算法，比自己写的好在直接在循环内计算数字，也没有借助额外的空间。这题关键点在于判断反转后的数字是否越界。

```java
class Solution {
    public int reverse(int x) {
        int ret = 0;
        while (x != 0) {
            int t = x % 10;
            if ((ret > Integer.MAX_VALUE / 10) || (ret == Integer.MAX_VALUE / 10 && t > 7)) {
                return 0;
            } else if ((ret < Integer.MIN_VALUE / 10) || (ret == Integer.MIN_VALUE / 10 && t < -8)) {
                return 0;
            }
            ret = ret * 10 + t;
            x = x / 10;
        }

        return ret;
    }
}
```
