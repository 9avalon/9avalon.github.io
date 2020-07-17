---
title : (Easy)路径总和
date: 2020-07-18 01:31:50
collection : 树
---

### 题目描述

```txt
给定一个二叉树和一个目标和，判断该树中是否存在根节点到叶子节点的路径，这条路径上所有节点值相加等于目标和。

说明: 叶子节点是指没有子节点的节点。

示例: 
给定如下二叉树，以及目标和 sum = 22，

              5
             / \
            4   8
           /   / \
          11  13  4
         /  \      \
        7    2      1
返回 true, 因为存在目标和为 22 的根节点到叶子节点的路径 5->4->11->2。

通过次数115,932提交次数227,962

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/path-sum
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

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
    public boolean hasPathSum(TreeNode root, int sum) {
        if (root == null) {
            return false;
        }
        return dfs(root, sum, 0);
    }

    private boolean dfs(TreeNode node, int sum, int cur) {
        if (node == null) {
            return false;
        }

        // 叶子节点
        if (node.left == null && node.right == null) {
            // 判断
            if (cur + node.val == sum) {
                return true;
            } else {
                return false;
            }
        }
        return dfs(node.left, sum, cur+node.val) || dfs(node.right, sum, cur+node.val);
    }
}
```

分析：必须要根节点才能成立，这点有点坑。


