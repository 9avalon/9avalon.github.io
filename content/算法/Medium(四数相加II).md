---
title: (Medium*)四数相加II
date: 2020-03-16 20:47:15
collection: 散列
---

```txt
给定四个包含整数的数组列表 A , B , C , D ,计算有多少个元组 (i, j, k, l) ，使得 A[i] + B[j] + C[k] + D[l] = 0。

为了使问题简单化，所有的 A, B, C, D 具有相同的长度 N，且 0 ≤ N ≤ 500 。所有整数的范围在 -228 到 228 - 1 之间，最终结果不会超过 231 - 1 。

例如:

输入:
A = [ 1, 2]
B = [-2,-1]
C = [-1, 2]
D = [ 0, 2]

输出:
2

解释:
两个元组如下:
1. (0, 0, 0, 1) -> A[0] + B[0] + C[0] + D[1] = 1 + (-2) + (-1) + 2 = 0
2. (1, 1, 0, 0) -> A[1] + B[1] + C[0] + D[0] = 2 + (-1) + (-1) + 0 = 0
```

题解:

```java
class Solution {
    public int fourSumCount(int[] A, int[] B, int[] C, int[] D) {
        Map<Integer, Integer> map1 = new HashMap<Integer, Integer>();
        for (int i=0; i<A.length; i++) {
            for (int j=0; j<B.length; j++) {
                int temp = A[i] + B[j];
                if (map1.containsKey(temp)) {
                    map1.put(temp, map1.get(temp) + 1);
                } else {
                    map1.put(temp, 1);
                }
            }
        }

        int sum = 0;
        for (int i=0; i<C.length; i++) {
            for (int j=0; j<D.length; j++) {
                int temp = -(C[i] + D[j]);
                if (map1.containsKey(temp)) {
                    sum += map1.get(temp);
                }
            }
        }

        return sum;
    }
}
```

分析: 看了题解，一开始还以为要用动态规划来做这题。。
