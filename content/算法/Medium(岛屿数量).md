---
title: (Medium)岛屿数量
date: 2020-03-30 00:22:20
collection: 图论
---

```txt
给定一个由 '1'（陆地）和 '0'（水）组成的的二维网格，计算岛屿的数量。一个岛被水包围，并且它是通过水平方向或垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。

示例 1:

输入:
11110
11010
11000
00000

输出: 1
示例 2:

输入:
11000
11000
00100
00011

输出: 3
```

题解:

最早的版本，用set实现，略慢，测试结果36ms

```java
class Solution {
    public int numIslands(char[][] grid) {
        Set<String> set = new HashSet<>();
        int count = 0;

        for (int i=0; i<grid.length; i++) {
            for (int j=0; j<grid[i].length; j++) {
                if (grid[i][j] == '0') {
                    continue;
                }

                if (set.contains(i + "-" + j)) {
                    continue;
                }

                count ++;
                dfs(set, grid, i, j);
            }
        }
        return count;
    }

    private void dfs(Set<String> set, char[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length) {
            return;
        }

        if (j < 0 || j >= grid[i].length) {
            return;
        }

        if (set.contains(i + "-" + j)) {
            return;
        }

        if (grid[i][j] == '0') {
            return;
        }

        set.add(i + "-" + j);
        dfs(set, grid, i, j-1); // 左
        dfs(set, grid, i, j+1); // 右
        dfs(set, grid, i-1, j); // 上
        dfs(set, grid, i+1, j); // 下
    }
}
```

改版版，去掉set，测试结果2ms

```java
class Solution {
    public int numIslands(char[][] grid) {
        int count = 0;

        for (int i=0; i<grid.length; i++) {
            for (int j=0; j<grid[i].length; j++) {
                if (grid[i][j] == '0') {
                    continue;
                }

                count ++;
                dfs(grid, i, j);
            }
        }
        return count;
    }

    private void dfs(char[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length) {
            return;
        }

        if (j < 0 || j >= grid[i].length) {
            return;
        }

        if (grid[i][j] == '0') {
            return;
        }

        grid[i][j] = '0';
        dfs(grid, i, j-1); // 左
        dfs(grid, i, j+1); // 右
        dfs(grid, i-1, j); // 上
        dfs(grid, i+1, j); // 下
    }
}
```

分析: dfs，永远滴神！
