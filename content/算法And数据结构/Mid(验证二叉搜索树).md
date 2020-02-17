---
title: (Mid)验证二叉搜索树
date: 2020-02-17 11:50:14
collection: 树
---

```txt
给定一个二叉树，判断其是否是一个有效的二叉搜索树。

假设一个二叉搜索树具有如下特征：

节点的左子树只包含小于当前节点的数。
节点的右子树只包含大于当前节点的数。
所有左子树和右子树自身必须也是二叉搜索树。
示例 1:

输入:
    2
   / \
  1   3
输出: true
示例 2:

输入:
    5
   / \
  1   4
     / \
    3   6
输出: false
解释: 输入为: [5,1,4,null,null,3,6]。
     根节点的值为 5 ，但是其右子节点值为 4 。
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
    public boolean isValidBST(TreeNode root) {
        return next(root, null, null);
    }

    private boolean next(TreeNode root, Integer lower, Integer upper) {
        if (root == null) {
            return true;
        }

        if (lower != null && lower >= root.val) {
            return false;
        }

        if (upper != null && upper <= root.val) {
            return false;
        }

        boolean leftRet = next(root.left, lower, root.val);
        boolean rightRet = next(root.right, root.val, upper);

        if (!leftRet || !rightRet) {
            return false;
        }

        return true;
    }
}
```

分析: 递归，要验证子树是不是bst
