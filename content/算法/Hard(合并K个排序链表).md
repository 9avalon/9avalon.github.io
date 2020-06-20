---
title: (Hard)合并K个排序链表
date: 2020-03-07 13:38:03
collection: 链表
---

```txt
合并 k 个排序链表，返回合并后的排序链表。请分析和描述算法的复杂度。

示例:

输入:
[
  1->4->5,
  1->3->4,
  2->6
]
输出: 1->1->2->3->4->4->5->6

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/merge-k-sorted-lists
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

自己题解:

这是暴力破解的，1s多很慢

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
    public ListNode mergeKLists(ListNode[] lists) {

        ListNode head = new ListNode(0);

        Map<Integer, ListNode> map = new HashMap<>();
        for (int i=0; i<lists.length; i++) {
            map.put(i, lists[i]);   
        }

        ListNode temp = head;
        while (true) {
            int min = Integer.MAX_VALUE;
            Integer minIndex = null;
            for (Integer i : map.keySet()) {
                ListNode listNode = map.get(i);
                if (listNode == null) {
                    continue;
                }
                if (listNode.val < min) {
                    min = listNode.val;
                    minIndex = i;
                }
            }
            // 得到最小值的处理
            if (minIndex == null) {
                break;
            }
            ListNode minNode = map.get(minIndex);
            if (minNode.next == null) {
                map.remove(minIndex);
            } else {
                map.put(minIndex, minNode.next);
            }
            temp.next = new ListNode(min);
            temp = temp.next;

        }

        return head.next;
    }
}
```

看了题解，改用优先队列来实现... 9ms

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
    public ListNode mergeKLists(ListNode[] lists) {
        Queue<Integer> queue = new PriorityQueue<Integer>((a, b) -> {
            return a.compareTo(b);
        });

        for (int i=0; i<lists.length; i++) {
            ListNode listNode = lists[i];
            while (listNode != null) {
                queue.add(listNode.val);
                listNode = listNode.next;
            }
        }

        ListNode head = new ListNode(0);
        ListNode temp = head;
        while (queue.size() != 0) {
            temp.next = new ListNode(queue.poll());
            temp = temp.next;
        }
        return head.next;
    }
}
```
