---
title: (Easy)合并两个有序链表
date: 2020-02-14 01:42:06 
collection: 链表
---

```txt
将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。 

示例：

输入：1->2->4, 1->3->4
输出：1->1->2->3->4->4
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
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        ListNode head = new ListNode(0);
        ListNode merge = head;
        while(l1 != null || l2 != null) {
            if (l1 == null) {
                merge.next = l2;
                l2 = l2.next;
                merge = merge.next;
                continue;
            }

            if (l2 == null) {
                merge.next = l1;
                l1 = l1.next;
                merge = merge.next;
                continue;
            }

            if (l1.val <= l2.val) {
                merge.next = l1;
                l1 = l1.next;
            } else {
                merge.next = l2;
                l2 = l2.next;
            }

            merge = merge.next;
        }

        return head.next;
    }
}
```

分析: while的判断里栽了跟斗，判断错了，本来这题可以更快解出来的。
