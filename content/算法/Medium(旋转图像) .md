---
title: (Medium)旋转图像
date: 2020-01-27 11:56:15
collection: 数组
---

```txt
给定一个 n × n 的二维矩阵表示一个图像。

将图像顺时针旋转 90 度。

说明：

你必须在原地旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要使用另一个矩阵来旋转图像。

示例 1:

给定 matrix = 
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

原地旋转输入矩阵，使其变为:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]
示例 2:

给定 matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
], 

原地旋转输入矩阵，使其变为:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]
```

自己题解:

```java
class Solution {
    public void rotate(int[][] matrix) {
        // 先翻转矩阵
        for (int i=0; i<matrix.length/2; i++) {
            for (int j=0; j<matrix.length; j++) {
                int t = matrix[i][j];
                matrix[i][j] = matrix[matrix[i].length-i-1][j];
                matrix[matrix[i].length-i-1][j] = t;
            }
        }
        // 对称
        for (int i=0; i<matrix.length; i++) {
            for (int j=0; j<i; j++) {
                int t = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = t;
            }
        }
    }
}
```

分析:

1.想了半天没想出来，后面看了题解。

2.思路是先翻转矩阵，然后再对角线对称。

```txt
翻转整个数组,再按正对角线交换两边的数

[                    [                  [
  [1,2,3],             [7,8,9],            [7,4,1],
  [4,5,6],    ---->    [4,5,6], ----->     [8,5,2],
  [7,8,9]              [1,2,3]             [9,6,3] 
]                    ]                  ]
```