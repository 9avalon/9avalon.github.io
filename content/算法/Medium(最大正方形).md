---
title: (Medium)最大正方形
date: 2020-06-25 22:58:13
collection: 动态规划
---

```txt
在一个由 0 和 1 组成的二维矩阵内，找到只包含 1 的最大正方形，并返回其面积。

示例:

输入:

1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0

输出: 4

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/maximal-square
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public int maximalSquare(char[][] matrix) {
        if (matrix.length == 0) {
            return 0;
        }
        //dp[i][j] = Math.min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1;
        int[][] dp = new int[matrix.length][matrix[0].length];
        int max = 0;
        for (int i=0; i<matrix.length; i++) {
            for (int j=0; j<matrix[i].length; j++) {
                if (matrix[i][j] == '0') {
                    dp[i][j] = 0;
                    continue;
                }
                int left = i-1 >= 0 ? dp[i-1][j] : 0;
                int mid = i-1 >=0 && j-1 >= 0 ? dp[i-1][j-1] : 0;
                int right = j-1 >= 0 ? dp[i][j-1] : 0;

                int v = Integer.MAX_VALUE;
                v = Math.min(left, v);
                v = Math.min(mid, v);
                v = Math.min(right, v);
                v += 1;

                max = Math.max(v*v, max);
                dp[i][j] = v;
            }
        }
        return max;
    }
}
```

分析: 看了题解，555555，动规都有点难.


