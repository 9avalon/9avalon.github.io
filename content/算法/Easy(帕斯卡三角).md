---
title: (Easy)帕斯卡三角
date: 2020-03-05 00:00:56
collection: 其他
---

```txt
给定一个非负整数 numRows，生成杨辉三角的前 numRows 行。

在杨辉三角中，每个数是它左上方和右上方的数的和。

示例:

输入: 5
输出:
[
     [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]
]
```

自己题解:

```java
class Solution {
    public List<List<Integer>> generate(int numRows) {
        List<List<Integer>> totalList = new ArrayList();
        for (int i=0; i<numRows; i++) {
            List<Integer> list = new ArrayList();
            for (int j=0; j<=i; j++) {
                if (j == 0 || j == i) {
                    list.add(1);
                    continue;
                }

                int temp = totalList.get(i-1).get(j-1) + totalList.get(i-1).get(j);
                list.add(temp);
            }
            totalList.add(list);
        }

        return totalList;
    }
}
```

分析: 这题还是挺简单的，手写15分钟写出来了。