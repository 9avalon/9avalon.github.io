---
title: (Hard)二叉树中的最大路径和
date: 2020-03-24 23:36:21
collection: 树
---

```txt
给定一个非空二叉树，返回其最大路径和。

本题中，路径被定义为一条从树中任意节点出发，达到任意节点的序列。该路径至少包含一个节点，且不一定经过根节点。

示例 1:

输入: [1,2,3]

       1
      / \
     2   3

输出: 6
示例 2:

输入: [-10,9,20,null,null,15,7]

   -10
   / \
  9  20
    /  \
   15   7

输出: 42
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

    private int max = Integer.MIN_VALUE;

    public int maxPathSum(TreeNode root) {
        dfs(root);
        return max;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }
        // 后续遍历
        int left = Math.max(dfs(node.left), 0);
        int right = Math.max(dfs(node.right), 0);

        int tempAll = node.val + left + right;

        max = Math.max(max, tempAll);

        return node.val + Math.max(left, right);
    }
}
```

分析: 递归，有点绕
