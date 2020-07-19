---
title: (Medium)二叉树的右视图
date: 2020-05-21 22:58:05
collection: 树
---

```txt
给定一棵二叉树，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。

示例:

输入: [1,2,3,null,5,null,4]
输出: [1, 3, 4]
解释:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/binary-tree-right-side-view
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
    private Set<Integer> set = new HashSet<>();

    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        rightSide(root, 0, result);
        return result;
    }

    private void rightSide(TreeNode node, int level, List<Integer> result) {
        if (node == null) {
            return;
        }
        if (!set.contains(level)) {
            result.add(node.val);
        }

        set.add(level);

        rightSide(node.right, level + 1, result);
        rightSide(node.left, level + 1, result);
    }
}
```

分析: 这题做得略爽，换个思路，逆转正常的先序遍历就ok了。
