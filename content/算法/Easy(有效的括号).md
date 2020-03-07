---
title: (Easy)帕斯卡三角
date: 2020-03-05 00:26:44
collection: 栈
---

```txt
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：

左括号必须用相同类型的右括号闭合。
左括号必须以正确的顺序闭合。
注意空字符串可被认为是有效字符串。

示例 1:

输入: "()"
输出: true
示例 2:

输入: "()[]{}"
输出: true
示例 3:

输入: "(]"
输出: false
示例 4:

输入: "([)]"
输出: false
示例 5:

输入: "{[]}"
输出: true
```

自己题解:

```java
class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();

        for (int i=0; i<s.length(); i++) {
            if (s.charAt(i) == '}') {
                if (stack.size() == 0 || !Objects.equals('{', stack.pop())){
                    return false;
                } {
                    continue;
                }
            }

            if (s.charAt(i) == ')') {
                if (stack.size() == 0 || !Objects.equals('(', stack.pop())){
                    return false; 
                } else {
                    continue;
                }
            }

            if (s.charAt(i) == ']') {
                if (stack.size() == 0 || !Objects.equals('[', stack.pop())){
                    return false;
                } else {
                    continue;
                }
            }

            stack.push(s.charAt(i));
        }

        return stack.size() == 0;
    }
}
```

分析: 典型的用栈匹配，想起了当年大学的时候，用c++写这个东西还挺费劲的，现在写起来就简单多了。
