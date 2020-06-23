---
title: (Medium)二叉树展开为链表
date: 2020-06-23 01:14:33
collection: 树
---

```txt
给定一个二叉树，原地将它展开为一个单链表。

 

例如，给定二叉树

    1
   / \
  2   5
 / \   \
3   4   6
将其展开为：

1
 \
  2
   \
    3
     \
      4
       \
        5
         \
          6

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public void flatten(TreeNode root) {
        // start 00:53 
        TreeNode node = root;
        while (node != null) {
            if (node.left == null) {
                node = node.right;
                continue;
            }

            // 找到左树的最右节点
            TreeNode leftRight = node.left;
            while (leftRight.right != null) {
                leftRight = leftRight.right;
            }
            // 将右子树节点挂到左子树最右节点
            leftRight.right = node.right;

            node.right = node.left;
            node.left = null;
            node = node.right;
        }
    }
}
```

分析: 15分钟没想出来，看了题解。这种解法真的好巧妙。