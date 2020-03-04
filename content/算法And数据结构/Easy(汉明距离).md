---
title : (Easy)汉明距离
date: 2020-03-04 13:09:37
collection : 位运算
---

### 题目描述

```txt
两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。

给出两个整数 x 和 y，计算它们之间的汉明距离。

注意：
0 ≤ x, y < 231.

示例:

输入: x = 1, y = 4

输出: 2

解释:
1   (0 0 0 1)
4   (0 1 0 0)
       ↑   ↑

上面的箭头指出了对应二进制位不同的位置。
```

```java
class Solution {
    public int hammingDistance(int x, int y) {
        Integer xor = x ^ y;

        Integer temp = 1;
        Integer sum = 0;
        for (int i=0; i<32; i++) {
            if ( (xor & temp) != 0) {
                sum ++;
            }
            temp = temp << 1;
        }

        return sum;
    }
}
```

分析：异或的思想，先异或，得到结果中，为1的就是差异的位置，然后再统计数字位置1的个数。
