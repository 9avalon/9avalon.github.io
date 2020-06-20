---
title: (Medium) 括号生成
date: 2020-06-20 16:43:48
collection: 字符串
---

```txt
数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。

示例：

输入：n = 3
输出：[
       "((()))",
       "(()())",
       "(())()",
       "()(())",
       "()()()"
     ]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/generate-parentheses
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<String> generateParenthesis(int n) {
        List<String> s = new ArrayList<>();
        loop(1, 2*n, 0, "", s);
        return s;
    }

    private void loop(int index, int n, int balance, String s, List<String> ret) {
        if (balance < 0 || balance > n) {
            return;
        }

        if (index > n){
            if (balance == 0) {
                // 合法
                ret.add(s);
                return;
            } else {
                return;
            }
        }


        loop(index+1, n, balance+1, s + "(", ret);
        loop(index+1, n, balance-1, s + ")", ret);
    }
}
```

分析: 一开始想岔了，头铁用栈来做，后面瞄了一下题解，发现可以用简单的计数法来判断，真的妙啊。
