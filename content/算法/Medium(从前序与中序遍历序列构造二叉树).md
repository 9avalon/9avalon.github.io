---
title: (Medium)从前序与中序遍历序列构造二叉树
date: 2020-06-23 00:50:55
collection: 树
---

```txt
根据一棵树的前序遍历与中序遍历构造二叉树。

注意:
你可以假设树中没有重复的元素。

例如，给出

前序遍历 preorder = [3,9,20,15,7]
中序遍历 inorder = [9,3,15,20,7]
返回如下的二叉树：

    3
   / \
  9  20
    /  \
   15   7

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

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
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        // start=00:34 00:50

        // 方便快速遍历
        Map<Integer, Integer> map = new HashMap<>();
        for (int i=0; i<inorder.length; i++) {
            map.put(inorder[i], i);
        }

        return buildTree(preorder, inorder, 0, preorder.length - 1, 0, inorder.length - 1, map);
    }

    public TreeNode buildTree(int[] preorder, int[] inorder, int preLeft , int preRight, int inLeft, int inRight, Map<Integer, Integer> map) {
        if (preLeft > preRight) {
            return null;
        }

        // 构造主节点
        TreeNode treeNode = new TreeNode(preorder[preLeft]);

        int spiltMid = map.get(preorder[preLeft]);
        // 先序数组里面，左树和右树的节点
        int preSpilt = spiltMid - inLeft;

        // 构造左节点
        treeNode.left = buildTree(preorder, inorder, preLeft + 1, preLeft + preSpilt, inLeft, spiltMid - 1, map);
        // 构造右节点
        treeNode.right = buildTree(preorder, inorder, preLeft + preSpilt + 1, preRight, spiltMid + 1, inRight, map);

        return treeNode;
    }
}
```

分析: 太牛逼了，虽然说看了下题解，但是第一次直接AC的，连语法编译都没错，逻辑也没错，感动，这题递归里面挺难写的。
