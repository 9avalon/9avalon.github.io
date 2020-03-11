---
title: (Medium)基本计算器II
date: 2020-03-12 01:25:08
collection: 栈
---

```txt
实现一个基本的计算器来计算一个简单的字符串表达式的值。

字符串表达式仅包含非负整数，+， - ，*，/ 四种运算符和空格  。 整数除法仅保留整数部分。

示例 1:

输入: "3+2*2"
输出: 7
示例 2:

输入: " 3/2 "
输出: 1
示例 3:

输入: " 3+5 / 2 "
输出: 5
说明：

你可以假设所给定的表达式都是有效的。
请不要使用内置的库函数 eval。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/basic-calculator-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

自己题解:

```java
class Solution {
    public int calculate(String s) {
        s = s.replaceAll(" ", "");

        Stack<Integer> stack = new Stack<>();
        Character lastOperate = '+';
        for (int i=0; i<s.length(); i++) {
            if (s.charAt(i) >= '0' && s.charAt(i) <='9') {
                int j=i+1;
                int num = s.charAt(i) - '0';
                while (j < s.length()) {
                    if (s.charAt(j) >= '0' && s.charAt(j) <= '9') {
                        num = num * 10 + (s.charAt(j) - '0');
                        j++;
                        i++;
                    } else {
                        break;
                    }
                }

                if (lastOperate == '+') {
                    stack.push(num);
                } else if (lastOperate == '-') {
                    stack.push(-num);
                } else if (lastOperate == '*') {
                    stack.push(stack.pop() * num);
                } else if (lastOperate == '/') {
                    stack.push(stack.pop() / num);
                }
            } else {
                lastOperate = s.charAt(i);
            }
        }

        int ret = 0;
        while (stack.size() > 0) {
            ret += stack.pop();
        }

        return ret;
    }
}
```

分析: 这题有两点，第一点是需要将整数转数字，第二点是，先利用栈，将乘法和除法都计算好，将算好的结果放入栈，那栈里面的就都可以通过加法解决，妙哉。

ps：上面代码是比较挫，没毛病
