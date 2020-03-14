---
title: (Medium*)排序链表
date: 2020-03-14 22:11:26
collection: 链表
---

```txt
在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。

示例 1:

输入: 4->2->1->3
输出: 1->2->3->4
示例 2:

输入: -1->5->3->4->0
输出: -1->0->3->4->5
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
    public ListNode sortList(ListNode head) {
        return mergeSort(head);
    }

    private ListNode mergeSort(ListNode node) {
        if (node == null || node.next == null) {
            return node;
        }

        // 找链表的中点
        ListNode slow = node;
        ListNode fast = node.next;
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // 此时slow为中点

        // 对右边进行归并排序
        ListNode right = mergeSort(slow.next);

        // 断开节点
        slow.next = null;

        // 对左边进行归并排序
        ListNode left = mergeSort(node);

        return mergeList(left, right);
    }

    // 合并两个有序的列表
    private ListNode mergeList(ListNode left, ListNode right) {
        ListNode newNode = new ListNode(-1);
        ListNode temp = newNode;
        while (left != null && right != null) {
            if (left.val < right.val) {
                temp.next = left;
                left = left.next;
            } else {
                temp.next = right;
                right = right.next;
            }
            temp = temp.next;
        }

        temp.next = left == null ? right : left;
        return newNode.next;
    }
}
```

分析: 两个知识点，第一是可以通过快慢指针找链表中间节点，第二是短链然后归并，虽然说这题的目标是空间复杂度O(1)，后面二刷的时候，再尝试对这题进阶优化吧。
