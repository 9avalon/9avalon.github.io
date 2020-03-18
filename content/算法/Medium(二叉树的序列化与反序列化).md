---
title: (Medium)二叉树的序列化与反序列化
date: 2020-03-19 00:51:08
collection: 树
---

```txt
序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。

请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。

示例: 

你可以将以下二叉树：

    1
   / \
  2   3
     / \
    4   5

序列化为 "[1,2,3,null,null,4,5]"
提示: 这与 LeetCode 目前使用的方式一致，详情请参阅 LeetCode 序列化二叉树的格式。你并非必须采取这种方式，你也可以采用其他的方法解决这个问题。

说明: 不要使用类的成员 / 全局 / 静态变量来存储状态，你的序列化和反序列化算法应该是无状态的。
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
public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        if (root == null) {
            return "";
        }

        List<Integer> list = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);

        while (queue.size() > 0) {
            int size = queue.size();
            while (size > 0) {
                TreeNode treeNode = queue.poll();
                if (treeNode != null) {
                    queue.add(treeNode.left);
                    queue.add(treeNode.right);
                    list.add(treeNode.val);
                } else {
                    list.add(null);
                }
                size --;
            }
        }

        int length = list.size() - 1;
        for (int i=list.size() - 1; i>=0; i--) {
            if (list.get(i) != null) {
                length = i;
                break;
            }
        }
        List<Integer> strList = list.subList(0, length + 1);
        StringBuilder ret = new StringBuilder();
        for (int i=0; i<strList.size(); i++) {
            if (i == strList.size() - 1) {
                ret.append(strList.get(i));
            } else {
                ret.append(strList.get(i)).append(",");
            }
        }
        return ret.toString();
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        if (data == null || data.length() == 0) {
            return null;
        }

        String[] spilts = data.split(",");
        List<Integer> list = new ArrayList<>();
        for (String s : spilts) {
            list.add(Objects.equals("null", s) ? null : Integer.valueOf(s));
        }

        TreeNode head = new TreeNode(list.get(0));
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(head);

        int i = 0;
        while (queue.size() > 0) {
            int size = queue.size();
            while (size > 0) {
                TreeNode temp = queue.poll();
                int leftIndex = 2*i + 1;
                int rightIndex = 2*i + 2;
                if (leftIndex < list.size()) {
                    Integer val = list.get(leftIndex);
                    if (val != null) {
                        TreeNode left = new TreeNode(val);
                        temp.left = left;
                        queue.add(left);
                    }
                }
                if (rightIndex < list.size()) {
                    Integer val = list.get(rightIndex);
                    if (val != null) {
                        TreeNode right = new TreeNode(val);
                        temp.right = right;
                        queue.add(right);
                    }
                }
                i++;
                size--;
            }
        }
        return head;
    }
}

// Your Codec object will be instantiated and called as such:
// Codec codec = new Codec();
// codec.deserialize(codec.serialize(root));
```

分析:

1. 这题有毒，输出用例里面是带[]的，难怪我搞半天都a不了这一题。这题用层序遍历做，不难
