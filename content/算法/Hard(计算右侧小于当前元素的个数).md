---
title: (Hard*)计算右侧小于当前元素的个数
date: 2020-03-22 11:46:32
collection: 二叉搜索树
---

```txt
给定一个整数数组 nums，按要求返回一个新数组 counts。数组 counts 有该性质： counts[i] 的值是  nums[i] 右侧小于 nums[i] 的元素的数量。

示例:

输入: [5,2,6,1]
输出: [2,1,1,0]
解释:
5 的右侧有 2 个更小的元素 (2 和 1).
2 的右侧仅有 1 个更小的元素 (1).
6 的右侧有 1 个更小的元素 (1).
1 的右侧有 0 个更小的元素.
```

题解:

```java
class Solution {

    class TreeNode {
        int val;
        int count;
        TreeNode left;
        TreeNode right;

        public TreeNode(int val) {
            this.val = val;
            this.count = 0;
            this.left = null;
            this.right = null;
        }
    }

    public List<Integer> countSmaller(int[] nums) {
        List<Integer> ret = new ArrayList<>();
        for (int i=0; i<nums.length; i++) {
            ret.add(0);
        }

        TreeNode root = null;
        for (int i=nums.length-1; i>=0; i--) {
            TreeNode treeNode = new TreeNode(nums[i]);
            root = insert(root, treeNode, ret, i);
        }

        return ret;
    }

    private TreeNode insert(TreeNode root, TreeNode treeNode, List<Integer> ret, Integer index) {
        if (root == null) {
            root = treeNode;
            return root;
        }

        if (root.val >= treeNode.val) {
            root.count ++;
            root.left = insert(root.left, treeNode, ret, index);
        } else {
            ret.set(index, ret.get(index) + root.count + 1);
            root.right = insert(root.right, treeNode, ret, index);
        }
        return root;
    }
}
```

分析:

1.这题自己想到的是暴力破解，但是会超时

2.看了题解，方法是构造二叉搜索树，减少重复的比较。
