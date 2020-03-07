---
title: (Easy)爬楼图
date: 2020-02-21 13:09:10
collection: 动态规划
---

```txt
假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

注意：给定 n 是一个正整数。

示例 1：

输入： 2
输出： 2
解释： 有两种方法可以爬到楼顶。
1.  1 阶 + 1 阶
2.  2 阶
示例 2：

输入： 3
输出： 3
解释： 有三种方法可以爬到楼顶。
1.  1 阶 + 1 阶 + 1 阶
2.  1 阶 + 2 阶
3.  2 阶 + 1 阶
```

自己题解:

```java
class Solution {

    public int climbStairs(int n) {
        Map<Integer, Integer> result = new HashMap<>();

        for (int i=1; i<=n; i++) {
            if (i == 1) {
                result.put(1,1);
                continue;
            } else if (i == 2) {
                result.put(2, 2);
                continue;
            }
            result.put(i, result.get(i-1) + result.get(i-2));
        }

        return result.get(n);

    }
}
```

分析: 很经验的动态规划入门题
