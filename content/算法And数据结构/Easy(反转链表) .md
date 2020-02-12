---
title: (Easy)反转链表
date: 2020-02-12 00:39:34
collection: 链表
---

```txt
反转一个单链表。

示例:

输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
进阶:
你可以迭代或递归地反转链表。你能否用两种方法解决这道题？
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
    public ListNode reverseList(ListNode head) {
        if (head == null) {
            return null;
        }

        if (head.next == null) {
            return head;
        }

        ListNode slow = head;
        ListNode fast = head.next;
        ListNode temp = null;
        while (true) {
            temp = fast.next;
            fast.next = slow;

            if (slow == head) {
                slow.next = null;
            }

            slow = fast;
            if (temp == null) {
                return fast;
            } else {
                fast = temp;
            }
        }
    }
}
```

分析: 循环法
