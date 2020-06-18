---
title: (Medium)两数相加
date: 2020-06-18 14:06:40
collection: 链表
---

```txt
给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

示例：

输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
输出：7 -> 0 -> 8
原因：342 + 465 = 807

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/add-two-numbers
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

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
        ListNode p1 = l1;
        ListNode p2 = l2;

        // fake
        ListNode ret = new ListNode();

        int next = 0;
        ListNode t = ret;
        while (p1 != null || p2 != null) {
            int sum = next;
            if (p1 != null) {
                sum += p1.val;
            }
            if (p2 != null) {
                sum += p2.val;
            }

            if (sum >= 10) {
                next = 1;
                sum = sum % 10;
            } else {
                next = 0;
            }

            ListNode temp = new ListNode(sum);
            t.next = temp;
            t = temp;

            if (p1 != null) {
                p1 = p1.next;
            }
            if (p2 != null) {
                p2 = p2.next;
            }
        }

        if (next == 1) {
            t.next = new ListNode(1);
        }

        return ret.next;
    }
}
```

分析: 原来逆序是为了更好的计算
