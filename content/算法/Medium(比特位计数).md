---
title: (Medium)比特位计数
date: 2020-06-26 11:03:11
collection: 位运算
---

```txt
给定一个非负整数 num。对于 0 ≤ i ≤ num 范围中的每个数字 i ，计算其二进制数中的 1 的数目并将它们作为数组返回。

示例 1:

输入: 2
输出: [0,1,1]
示例 2:

输入: 5
输出: [0,1,1,2,1,2]
进阶:

给出时间复杂度为O(n*sizeof(integer))的解答非常容易。但你可以在线性时间O(n)内用一趟扫描做到吗？
要求算法的空间复杂度为O(n)。
你能进一步完善解法吗？要求在C++或任何其他语言中不使用任何内置函数（如 C++ 中的 __builtin_popcount）来执行此操作。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/counting-bits
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

第一版，性能比较差，6ms，击败12%

```java
class Solution {
    public int[] countBits(int num) {
        int[] ret = new int[num+1];
        for (int i=0; i<=num; i++) {
            ret[i] = count(i);
        }
        return ret;
    }

    private int count(int num) {
        int c = 0;
        while (num != 0) {
            if ((num & 1) == 1) {
                c ++;
            }
            num = num >> 1;
        }
        return c;
    }
}
```

```java
class Solution {
    public int[] countBits(int num) {
        int[] ret = new int[num+1];
        ret[0] = 0;
        for (int i=1; i<=num; i++) {
            if (i % 2 == 0) {
                // 偶数
                ret[i] = ret[i/2];
            } else {
                // 奇数
                ret[i] = ret[i-1] + 1;
            }
        }
        return ret;
    }
}
```

分析: 第一种是暴力法，第二种是动态规划推算过程如下

```txt
0    0
1    1
2   10
3   11
4  100
5  101
6  110
7  111

奇数: 3，5  dp[n-1] + 1
偶数: 2,4 6 dp[n/2]
```
