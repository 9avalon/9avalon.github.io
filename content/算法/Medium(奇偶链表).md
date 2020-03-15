---
title: (Medium)奇偶链表
date: 2020-03-15 12:09:28
collection: 链表
---

```txt
给定一个单链表，把所有的奇数节点和偶数节点分别排在一起。请注意，这里的奇数节点和偶数节点指的是节点编号的奇偶性，而不是节点的值的奇偶性。

请尝试使用原地算法完成。你的算法的空间复杂度应为 O(1)，时间复杂度应为 O(nodes)，nodes 为节点总数。

示例 1:

输入: 1->2->3->4->5->NULL
输出: 1->3->5->2->4->NULL
示例 2:

输入: 2->1->3->5->6->4->7->NULL 
输出: 2->3->6->7->1->5->4->NULL
说明:

应当保持奇数节点和偶数节点的相对顺序。
链表的第一个节点视为奇数节点，第二个节点视为偶数节点，以此类推。
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
    public ListNode oddEvenList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }

        ListNode slowHead = head;
        ListNode fastHead = head.next;
        ListNode slow = slowHead;
        ListNode fast = fastHead;

        while (true) {
            int count = 0;
            if (slow.next != null && slow.next.next != null) {
                ListNode temp = slow.next.next;
                slow.next = slow.next.next;
                slow = temp;
                count ++;
            }
            if (fast.next != null && fast.next.next != null) {
                ListNode temp = fast.next.next;
                fast.next = fast.next.next;
                fast = temp;
                count ++;
            }

            if (count == 0) {
                slow.next = null;
                fast.next = null;
                break;
            }
        }

        slow.next = fastHead;
        return slowHead;
    }
}
```

分析: 这题还行，我觉得拿去出面试题挺好
