---
title: (Medium)反转链表 II
date: 2020-07-18 09:59:35
collection: 链表
---

```txt
反转从位置 m 到 n 的链表。请使用一趟扫描完成反转。

说明:
1 ≤ m ≤ n ≤ 链表长度。

示例:

输入: 1->2->3->4->5->NULL, m = 2, n = 4
输出: 1->4->3->2->5->NULL

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/reverse-linked-list-ii
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
    public ListNode reverseBetween(ListNode head, int m, int n) {
        // 0->1->[2->3->4]->5->NULL m=2,n=4
        // 0->1->3->2
        // 0->1->4->3->2->5->NULL

        // 加个fake头节点
        ListNode fake = new ListNode(0);
        fake.next = head;

        // 找到要定位的节点位置
        ListNode preHead = fake;
        ListNode slow = head;
        ListNode fast = head;
        for (int i=1; i<m; i++) {
            preHead = preHead.next;
            slow = slow.next;
        }
        for (int i=1; i<n; i++) {
            fast = fast.next;
        }

        // 头节点连接到尾节点
        preHead.next = fast;

        // 反转链表
        ListNode end = fast.next;
        ListNode s = slow;
        ListNode f = slow.next;
        while (f != end) {
            ListNode temp = f.next;
            f.next = s;
            if (s == slow) {
                s.next = end;
            }
            s = f;
            f = temp;
        }

        return fake.next;
    }
}
```

分析: 直接做的，按拆分步骤做就好。
