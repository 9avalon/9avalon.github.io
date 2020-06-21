---
title: (Medium)不同路径
date: 2020-06-21 21:40:01
collection: 动态规划
---

```txt
一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

问总共有多少条不同的路径？

例如，上图是一个7 x 3 的网格。有多少可能的路径？

示例 1:

输入: m = 3, n = 2
输出: 3
解释:
从左上角开始，总共有 3 条路径可以到达右下角。
1. 向右 -> 向右 -> 向下
2. 向右 -> 向下 -> 向右
3. 向下 -> 向右 -> 向右
示例 2:

输入: m = 7, n = 3
输出: 28

提示：

1 <= m, n <= 100
题目数据保证答案小于等于 2 * 10 ^ 9

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/unique-paths
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {

    int[][] dp;

    public int uniquePaths(int m, int n) {
        // start:21:25 end:21:40
        if (m == 1 && n == 1) {
            return 1;
        }

        dp = new int[m][n];
        for (int i=0; i<m; i++) {
            for (int j=0; j<n; j++) {
                dp[i][j] = -1;
            }
        }

        if (m > 1) {
            dp[1][0] = 1;
        }
        if (n > 1) {
            dp[0][1] = 1;
        }
        dp[0][0] = 0;
        return find(m, n , m-1, n-1);
    }

    private int find(int m, int n, int x, int y) {
        if (x >= m || y >= n || x < 0 || y < 0) {
            return 0;
        } 
        if (dp[x][y] != -1) {
            return dp[x][y];
        }
        int ret = find(m, n, x-1, y) + find(m, n, x, y-1);
        dp[x][y] = ret;
        return ret;
    }
}
```

分析: 经典动态规划
