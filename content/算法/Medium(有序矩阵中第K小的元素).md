---
title: (Medium)有序矩阵中第K小的元素
date: 2020-03-09 23:43:29
collection: 堆
---

```txt
给定一个 n x n 矩阵，其中每行和每列元素均按升序排序，找到矩阵中第k小的元素。
请注意，它是排序后的第k小元素，而不是第k个元素。

示例:

matrix = [
   [ 1,  5,  9],
   [10, 11, 13],
   [12, 13, 15]
],
k = 8,

返回 13。
说明:
你可以假设 k 的值永远是有效的, 1 ≤ k ≤ n2 。
```

题解:

```java
class Solution {
    public int kthSmallest(int[][] matrix, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>(k);
        for (int y=0; y<matrix.length; y++) {
            for (int x=0; x<matrix[y].length; x ++) {
                minHeap.add(matrix[y][x]);
            }
        }

        for (int i=0; i<k-1; i++) {
            minHeap.poll();
        }
        return minHeap.poll();
    }
}
```

分析: 用堆实现超快
