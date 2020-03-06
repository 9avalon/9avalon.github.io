---
title: (Medium*) 搜索二维矩阵 II
date: 2020-03-06 00:59:37
collection: 二维数组
---

```txt
编写一个高效的算法来搜索 m x n 矩阵 matrix 中的一个目标值 target。该矩阵具有以下特性：

每行的元素从左到右升序排列。
每列的元素从上到下升序排列。
示例:

现有矩阵 matrix 如下：

[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
给定 target = 5，返回 true。

给定 target = 20，返回 false。
```

自己题解:

```java
class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        int y = matrix.length - 1;
        int x = 0;

        while (y >= 0 && x < matrix[matrix.length-1].length) {
            int temp = matrix[y][x];
            if (temp == target) {
                return true;
            } else if (temp > target) {
                y --;
            } else {
                x ++;
            }
        }

        return false;
    }
}
```

分析: 一开始搞了个递归，然后后面写完后发现这效率，和我直接遍历一样。。。然后看了答案，写出来了最优
