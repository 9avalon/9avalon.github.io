---
title: (Medium)删除链表的倒数第N个节点
date: 2020-02-12 00:39:34
collection: 链表
---

```txt
给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。

示例：

给定一个链表: 1->2->3->4->5, 和 n = 2.

当删除了倒数第二个节点后，链表变为 1->2->3->5.
说明：

给定的 n 保证是有效的。

进阶：

你能尝试使用一趟扫描实现吗？
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
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode p = new ListNode(0);
        p.next = head;

        int j = 0;
        ListNode tail = head;
        while (j < n - 1) {
            tail = tail.next;
            j++;
        }

        ListNode front = p;
        ListNode mid = head;
        while (tail != null) {
            if (tail.next == null) {
                front.next = mid.next;
                return p.next;
            }
            mid = mid.next;
            tail = tail.next;
            front = front.next;
        }

        return head;
    }
}
```

分析: 两个指针处理
