---
title: (Hard*)K个一组翻转链表
date: 2020-07-16 15:16:48
collection: 链表
---

```txt
给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。

k 是一个正整数，它的值小于或等于链表的长度。

如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。

 

示例：

给你这个链表：1->2->3->4->5

当 k = 2 时，应当返回: 2->1->4->3->5

当 k = 3 时，应当返回: 3->2->1->4->5

 

说明：

你的算法只能使用常数的额外空间。
你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reverse-nodes-in-k-group
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
    public ListNode reverseKGroup(ListNode head, int k) {
        if (head == null || k <= 0) {
            return head;
        }
        // 新增头结点
        ListNode newHead = new ListNode(0);
        newHead.next = head;

        ListNode pre = newHead;
        ListNode tail = newHead;
        ListNode slow = newHead.next;
        while (true) {
            // 尾结点往前走
            for (int i=0; i<k; i++) {
                if (tail == null) {
                    break;
                }
                tail = tail.next;
            }
            if (tail == null) {
                break;
            }

            ListNode temp = tail.next;

            // 头结点连到尾结点
            pre.next = tail;
            // 
            reverse(slow, tail);
            // 反转的尾结点指向下一个结点
            slow.next = temp;

            // 重新移动
            pre = slow;
            slow = pre.next;
            tail = pre;
        }

        return newHead.next;
    }

    private void reverse(ListNode slow, ListNode tail) {
        ListNode s = slow;
        ListNode f = slow.next;

        ListNode end = tail.next;
        while (f != end) {
            ListNode temp = f.next;
            f.next = s;
            if (s == slow) {
                s.next = null;
            }
            s = f;
            f = temp;
        }
    }
}
```

分析: 看了题解，增加头结点，然后各个情况的边界要出来好，这题即使思路清晰也很难写出来，我在idea上调试了20分钟才顺利AC。