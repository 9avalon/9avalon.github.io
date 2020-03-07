---
title: (Medium)二叉树的层次遍历
date: 2020-02-19 00:09:03
collection: 树
---

```txt
给定一个二叉树，返回其按层次遍历的节点值。 （即逐层地，从左到右访问所有节点）。

例如:
给定二叉树: [3,9,20,null,null,15,7],

    3
   / \
  9  20
    /  \
   15   7
返回其层次遍历结果：

[
  [3],
  [9,20],
  [15,7]
]
```

自己题解:

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public List<List<Integer>> levelOrder(TreeNode root) {
        if (root == null) {
            return new ArrayList();
        }

        List<List<Integer>> ret = new ArrayList();

        List<TreeNode> next = new ArrayList();
        List<TreeNode> current = Arrays.asList(root);
        while (current.size() > 0) {
            // 重置临时链表
            next = new ArrayList();

            List<Integer> list = new ArrayList();
            for (int i=0; i<current.size(); i++) {
                TreeNode t = current.get(i);
                list.add(t.val);

                if (t.left != null) {
                    next.add(t.left);
                }
                if (t.right != null) {
                    next.add(t.right);
                }
            }
            ret.add(list);
            current = next;
        }

        return ret;
    }
}
```

分析:

1. 觉得这题还挺简单的，没想到竟然是mid难度？😁
