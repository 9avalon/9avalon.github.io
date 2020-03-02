---
title : (Easy)计算质数
date: 2020-03-03 00:06:56
collection : 数学问题
---

### 题目描述

```txt
统计所有小于非负整数 n 的质数的数量。

示例:

输入: 10
输出: 4
解释: 小于 10 的质数一共有 4 个, 它们是 2, 3, 5, 7 。
```

```java
class Solution {
    public int countPrimes(int n) {
        boolean[] isPrimes = new boolean[n+1];

        // 将所有数组赋值为true
        for (int i=2; i<=n ; i++) {
            isPrimes[i] = true;
        }

        // 标记
        for (int i=2; i<n; i++) {
            if (isPrimes[i]) {
                for (int j= 2 * i; j<n; j+=i) {
                    isPrimes[j] = false;
                }
            }
        }

        int count = 0;
        for (int i=2; i<n; i++) {
            if (isPrimes[i]) {
                count ++;
            }
        }

        return count;
    }
}
```

分析：一般人应该也只会想到暴力破解。。。
