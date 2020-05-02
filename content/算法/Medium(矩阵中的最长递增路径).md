---
title: (Medium)矩阵中的最长递增路径
date: 2020-05-02 16:12:50
collection: 动态规划
---

```txt
给定一个整数矩阵，找出最长递增路径的长度。

对于每个单元格，你可以往上，下，左，右四个方向移动。 你不能在对角线方向上移动或移动到边界外（即不允许环绕）。

示例 1:

输入: nums =
[
  [9,9,4],
  [6,6,8],
  [2,1,1]
]
输出: 4
解释: 最长递增路径为 [1, 2, 6, 9]。
示例 2:

输入: nums =
[
  [3,4,5],
  [3,2,6],
  [2,2,1]
]
输出: 4
解释: 最长递增路径是 [3, 4, 5, 6]。注意不允许在对角线方向上移动。
```

题解:

```java
class Solution {

    public int longestIncreasingPath(int[][] matrix) {
        Map<String, Integer> dp = new HashMap<String, Integer>();
        for (int i=0; i<matrix.length; i++) {
            for (int j=0; j<matrix[i].length; j++) {
                dfs(matrix, i, j, dp);
            }
        }

        Integer max = 0;
        for (String key : dp.keySet()) {
            max = Math.max(dp.get(key), max);
        }
        return max;
    }

    private int dfs(int[][] matrix, int i, int j, Map<String, Integer> dp) {
        Integer value = dp.get(i + "-" + j);
        if (value != null) {
            return value;
        }

        int max = 1;
        if ((i < 0 || i >= matrix.length) || (j < 0 || j >= matrix[i].length)) {
            return max;
        }

        // 上
        if (i-1 >=0 && matrix[i][j] < matrix[i-1][j]) {
            max = Math.max(dfs(matrix, i-1, j, dp) + 1, max);
        }

        // 下
        if (i+1 < matrix.length && matrix[i][j] < matrix[i+1][j]) {
            max = Math.max(dfs(matrix, i+1, j, dp) + 1, max);
        }

        // 左
        if (j-1 >= 0 && matrix[i][j] < matrix[i][j-1]) {
            max = Math.max(dfs(matrix, i, j-1, dp) + 1, max);
        }

        // 右
        if (j+1 < matrix[i].length && matrix[i][j] < matrix[i][j+1]) {
            max = Math.max(dfs(matrix, i, j+1, dp) + 1, max);
        }

        dp.put(i + "-" + j, max);

        return max;
    }

}
```

分析: dfs+动态规划，现在做这种动态规划的题，第一步是先用最笨的方法递归，然后看有没有机会记录下重复计算的结果值，减少重复计算，就ok了。
