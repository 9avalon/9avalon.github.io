---
title: (Medium)两数相加 II
date: 2020-07-18 11:18:35
collection: 链表
---

```txt
给你两个 非空 链表来代表两个非负整数。数字最高位位于链表开始位置。它们的每个节点只存储一位数字。将这两数相加会返回一个新的链表。

你可以假设除了数字 0 之外，这两个数字都不会以零开头。

 

进阶：

如果输入链表不能修改该如何处理？换句话说，你不能对列表中的节点进行翻转。

 

示例：

输入：(7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
输出：7 -> 8 -> 0 -> 7

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/add-two-numbers-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

自己题解:

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        // 10:48

        // 将两个链表推入栈
        Stack<Integer> left = new Stack<>();
        ListNode temp = l1;
        while (temp != null) {
            left.push(temp.val);
            temp = temp.next;
        }

        Stack<Integer> right = new Stack<>();
        temp = l2;
        while (temp != null) {
            right.push(temp.val);
            temp = temp.next;
        }

        int ret = 0;
        int plus = 0;
        int sqrt = 0;
        ListNode tempNode = null;
        while (left.size() > 0 || right.size() > 0) {
            int a = left.size() > 0 ? left.pop() : 0;
            int b = right.size() > 0 ? right.pop() : 0;

            int num = a + b + plus;

            ListNode node = new ListNode(num % 10);
            node.next = tempNode;
            tempNode = node;

            if (num >= 10) {
                plus = 1;
            } else {
                plus = 0;
            }
        }

        // 处理最后的数据
        if (plus == 1) {
            ListNode newNode = new ListNode(1);
            newNode.next = tempNode;
            return newNode;
        }

        return tempNode;
    }
}
```

分析: 一开始还以为要递归去算，后面看了评论，竟然可以用栈。。。。
