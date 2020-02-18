---
title: (Easy)对称二叉树
date: 2020-02-19 00:05:24
collection: 树
---

```txt
给定一个二叉树，检查它是否是镜像对称的。

例如，二叉树 [1,2,2,3,4,4,3] 是对称的。

    1
   / \
  2   2
 / \ / \
3  4 4  3
但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:

    1
   / \
  2   2
   \   \
   3    3
说明:

如果你可以运用递归和迭代两种方法解决这个问题，会很加分。
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
    public boolean isSymmetric(TreeNode root) {
        return isMirror(root, root);
    }

    private boolean isMirror(TreeNode t1, TreeNode t2) {
        if (t1 == null && t2 == null) {
            return true;
        }

        if (t1 == null || t2 == null) {
            return false;
        }

        if (t1.val == t2.val && isMirror(t1.left, t2.right) && isMirror(t1.right, t2.left)) {
            return true;
        }
        return false;
    }
}
```

分析: 这题抄作业了，镜像这种类型有点苦手

一开始我的思路是复制一棵树出来，然后做反转这颗二叉树，然后对这两棵树做遍历，看看是不是所有节点都是一致的。后面看了别人的作业，发现很巧妙的递归。

关于迭代的方式，思路是解析每一层的数据，然后判断是不是回文。
