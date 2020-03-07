---
title : (Easy)3的幂
date: 2020-03-03 00:23:19
collection : 数学问题
---

### 题目描述

```txt
给定一个整数，写一个函数来判断它是否是 3 的幂次方。

示例 1:

输入: 27
输出: true
示例 2:

输入: 0
输出: false
示例 3:

输入: 9
输出: true
示例 4:

输入: 45
输出: false
进阶：
你能不使用循环或者递归来完成本题吗？
```

```java
class Solution {
    public boolean isPowerOfThree(int n) {
        if (n == 0) {
            return false;
        }
        if (n == 1) {
            return true;
        }
        if (n % 3 != 0) {
            return false;
        }

        int temp = 3;
        while (temp <= n) {
            if (temp == n) {
                return true;
            }

            temp *= 3;
        }

        return false;
    }
}
}
```

分析：略了略了
