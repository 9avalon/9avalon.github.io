---
title: (Medium)重排链表
date: 2020-07-18 03:05:11
collection: 链表
---

```txt
给定一个单链表 L：L0→L1→…→Ln-1→Ln ，
将其重新排列后变为： L0→Ln→L1→Ln-1→L2→Ln-2→…

你不能只是单纯的改变节点内部的值，而是需要实际的进行节点交换。

示例 1:

给定链表 1->2->3->4, 重新排列为 1->4->2->3.
示例 2:

给定链表 1->2->3->4->5, 重新排列为 1->5->2->4->3.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reorder-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public void reorderList(ListNode head) {
        if (head == null || head.next == null) {
            return;
        }

        // 快慢指针找到中点
        ListNode slow = head;
        ListNode fast = head;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // 拆为两个链表
        ListNode right = slow.next;
        slow.next = null;
        ListNode left = head;

        // 将右边的链表进行反转
        // 1->2->3->4
        // 4->3->2->1
        ListNode rightHead = null;
        if (right != null) {
            ListNode l = right;
            ListNode f = right.next;
            rightHead = f == null ? l : f;
            while (f != null) {
                ListNode t = f.next;
                if (t != null) {
                    rightHead = t;
                }
                f.next = l;
                if (l == right) {
                    l.next = null;
                }
                l = f;
                f = t;
            }
        }

        // 最后按缝隙插入
        // 1-2-3
        // 5-4
        ListNode temp = rightHead;
        ListNode leftTemp = left;
        while (temp != null) {
            ListNode tt = temp.next;
            ListNode t = leftTemp.next;
            leftTemp.next = temp;
            temp.next = t;

            temp = tt;
            leftTemp = t;
        }
    }
}
```

分析: 链表的题都好狗啊，要debug半天

本题解题思路 1.快慢指针找到中点 2.拆成两个链表 3.遍历两个链表，后面的塞到前面的“缝隙里”
