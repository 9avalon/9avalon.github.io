---
title: (Easy)二叉树的最大深度
date: 2020-02-16 22:06:07
collection: 树
---

```txt
给定一个二叉树，找出其最大深度。

二叉树的深度为根节点到最远叶子节点的最长路径上的节点数。

说明: 叶子节点是指没有子节点的节点。

示例：
给定二叉树 [3,9,20,null,null,15,7]，

    3
   / \
  9  20
    /  \
   15   7
返回它的最大深度 3 。
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
    public int maxDepth(TreeNode root) {
        return next(root, 0);
    }

    private int next(TreeNode node, int dep) {
        if (node == null) {
            return dep;
        }
        dep++;

        int depLeft = next(node.left, dep);
        int depRight = next(node.right, dep);

        return depLeft > depRight ? depLeft : depRight;
    }
}
```

分析: 递归解决
