---
title: 树的Z形输出
date: 2016-6-23 17:58:29
collection: 树
---

使用队列来进行bfs搜索，再用一个数字来记录遍历的次数即可
LinkedList可以方便的选择插入到最后面还是插入到最前面

```java
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> resultList = new ArrayList<List<Integer>>();
        if (root == null) return resultList ;
        Queue<TreeNode> quene = new LinkedList<TreeNode>();
        
        int sign = 1; //1代表从左到右，-1代表从右到左
        int depSum = 1;
        quene.add(root); //加入首节点
        while (quene.size()!=0){
        	LinkedList<Integer> tempList = new LinkedList<Integer>();
        	//临时存储，用于队列循环
        	int temp = depSum;
        	//重置次数
        	depSum = 0;
        	while (temp>0){
        		//取出元素加入
            	TreeNode node = quene.poll();
            	if (node.left != null) {
            		quene.add(node.left);
            		depSum++;
            	}
            	if (node.right != null){
            		quene.add(node.right);
            		depSum++;
            	} 
            	if (sign == 1) tempList.addLast(node.val);
            	else if (sign == -1) tempList.addFirst(node.val);
            	temp --;
        	}
        	sign = -sign;
        	resultList.add(tempList);
        }
        return resultList;
    }
```