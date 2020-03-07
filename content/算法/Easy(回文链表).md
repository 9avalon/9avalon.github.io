---
title: (Easy)回文链表
date: 2020-02-15 21:00:49
collection: 链表
---

```txt
请判断一个链表是否为回文链表。

示例 1:

输入: 1->2
输出: false
示例 2:

输入: 1->2->2->1
输出: true
进阶：
你能否用 O(n) 时间复杂度和 O(1) 空间复杂度解决此题？
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
    public boolean isPalindrome(ListNode head) {
        if (head == null || head.next == null) {
            return true;
        }

        // 快慢指针，找到中点
        ListNode fast = head;
        ListNode slow = head;
        while (fast.next != null && fast.next.next != null) {
            fast = fast.next.next;
            slow = slow.next;
        }

        // 翻转中点后的链表
        slow = reverse(slow.next);

        while(slow != null) {
            if (head.val != slow.val) {
                return false;
            } else {
                head = head.next;
                slow = slow.next;
            }
        }
        return true;
    }

    private ListNode reverse(ListNode head) {
        if (head.next == null) {
            return head;
        }
        ListNode newHead = reverse(head.next);
        head.next.next = head;
        head.next = null;
        return newHead;
    }
}
```

分析: 最优的算法没有想出来，看了评论区老哥的作业，思路是先用快慢指针找到中点，然后反转后半部分的链表，然后再进行比对。反转的部分用的是很巧妙的递归。
