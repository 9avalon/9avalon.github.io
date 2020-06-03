---
title: (Medium)最小路径和
date: 2020-06-04 01:39:05
collection: 动态规划
---

```txt
给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。

说明：每次只能向下或者向右移动一步。

示例:

输入:
[
  [1,3,1],
  [1,5,1],
  [4,2,1]
]
输出: 7
解释: 因为路径 1→3→1→1→1 的总和最小。
```

题解:

```java
class Solution {
    public int minPathSum(int[][] grid) {
        int[][] dp = new int[grid.length][grid[0].length];
        for (int i=0; i<dp.length; i++) {
            for (int j=0; j<dp[i].length; j++) {
                dp[i][j] = -1;
            }
        }
        dp[0][0] = grid[0][0];

        return minPath(grid, dp, grid.length-1, grid[0].length - 1);
    }

    private int minPath(int[][] grid, int[][] dp, int x, int y) {
        if (x < 0 || y < 0) {
            return Integer.MAX_VALUE;
        }

        if (dp[x][y] != -1) {
            return dp[x][y];
        }

        int minX = minPath(grid, dp, x-1, y);
        int minY = minPath(grid, dp, x, y-1);
        int num = Math.min(minX, minY) + grid[x][y];

        dp[x][y] = num;
        return num;
    }
}
```

分析: 两次ac，经典动态规划
