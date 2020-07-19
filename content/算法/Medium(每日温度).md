---
title: (Medium)每日温度
date: 2020-07-19 11:53:50
collection: 栈
---

```txt
请根据每日 气温 列表，重新生成一个列表。对应位置的输出为：要想观测到更高的气温，至少需要等待的天数。如果气温在这之后都不会升高，请在该位置用 0 来代替。

例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。

提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的均为华氏度，都是在 [30, 100] 范围内的整数。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/daily-temperatures
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {

    public class Node {
        int index;
        int temper;
        public Node(int index, int temper) {
            this.index = index;
            this.temper = temper;
        }
    }

    public int[] dailyTemperatures(int[] T) {
        int[] ret = new int[T.length];

        Stack<Node> stack = new Stack<>();

        for (int i=0; i<T.length; i++) {
            while (stack.size() > 0) {
                Node node = stack.peek();
                if (T[i] > node.temper) {
                    stack.pop();
                    // 计算相差天数
                    ret[node.index] = i - node.index;
                } else {
                    break;
                }
            }

            // 入栈
            stack.push(new Node(i, T[i]));
        }

        // 将栈剩余的元素置为0
        while (stack.size() > 0) {
            Node node = stack.pop();
            ret[node.index] = 0;
        }

        return ret;
    }
}
```

分析: 单调栈
