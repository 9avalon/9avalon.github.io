---
title: (Hard)二叉树的后序遍历
date: 2020-06-22 21:08:10
collection: 树
---

```txt
给定一个二叉树，返回它的 后序 遍历。

示例:

输入: [1,null,2,3]  
   1
    \
     2
    /
   3 

输出: [3,2,1]
进阶: 递归算法很简单，你可以通过迭代算法完成吗？

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/binary-tree-postorder-traversal
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
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
    public List<Integer> postorderTraversal(TreeNode root) {
        if (root == null) {
            return new ArrayList<>();
        }
        //20:59start
        Stack<TreeNode> stackLeft = new Stack<>();
        Stack<TreeNode> stackRight = new Stack<>();

        stackLeft.push(root);
        TreeNode cur = root;

        while (stackLeft.size() > 0) {
            TreeNode node = stackLeft.pop();
            stackRight.push(node);
            if (node.left != null) {
                stackLeft.push(node.left);
            }
            if (node.right != null) {
                stackLeft.push(node.right);
            }
        }

        List<Integer> ret = new ArrayList<>();
        while (stackRight.size() > 0) {
            ret.add(stackRight.pop().val);
        }
        return ret;
    }
}
```

分析: 双栈处理，记住就好。
