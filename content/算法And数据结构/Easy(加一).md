---
title: (Easy)加一
date: 2016-6-23 18:00:38
collection: 数组
---

结论：多条件处理

```txt
给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。

最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。

你可以假设除了整数 0 之外，这个整数不会以零开头。
œ
示例 1:

输入: [1,2,3]
输出: [1,2,4]
解释: 输入数组表示数字 123。
示例 2:

输入: [4,3,2,1]
输出: [4,3,2,2]
解释: 输入数组表示数字 4321。
```

自己题解:

```java
class Solution {
    public int[] plusOne(int[] digits) {
        int plus = 0;
        for (int i=digits.length-1; i< digits.length; i--) {
            if (i == digits.length-1 || plus == 1) {
                // 最后一位处理，以及进位处理
                int current = digits[i] + 1;
                if (current == 10) {
                    plus = 1;
                    digits[i] = 0;
                    if (i == 0) {
                        // 进位处理
                        int[] newArray = new int[digits.length +1 ];
                        newArray[0] = 1;
                        for (int k = 1; k< newArray.length; k++){
                            newArray[k] = 0;
                        }
                        return newArray;
                    } else {
                        continue;    
                    }
                } else {
                    digits[i] = current;
                    break;
                }                
            } else {
                break;
            }
        }
        return digits;
    }
}
```

分析:

这道题没有什么特殊的地方，主要考察当加一时，出现的进位和需要扩展数组的问题。