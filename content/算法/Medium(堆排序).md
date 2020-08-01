---
title: (Medium)堆排序
date: 2020-08-01 17:49:30
collection: 排序
---

```java
public class Soluction {

    public static void main(String[] args) {
        Soluction soluction = new Soluction();
        int[] tree = new int[]{5,4,1,6,8,9,0};
        soluction.sort(tree);
        System.out.println(tree);
    }

    private void sort(int[] tree) {
        // 构建最大堆
        buildHeap(tree);


        // 排序输出
        int index = tree.length - 1;
        while (index > 0) {
            int temp = tree[0];
            tree[0] = tree[index];
            tree[index] = temp;

            heapify(tree, index, 0);
            index --;
        }
    }

    /**
     * 构造堆
     * @param tree
     */
    private void buildHeap(int[] tree) {
        // 从最后一个非叶子节点开始heapify
        int lastParent = (tree.length / 2) - 1;
        for (int i=lastParent; i>=0 ; i--) {
            heapify(tree, tree.length - 1, i);
        }
    }

    /**
     * 堆化，将i节点以及底下的构建堆
     * @param tree
     * @param n
     * @param i
     */
    private void heapify(int[] tree, int n, int i) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int max = i;

        if (left < n && tree[left] > tree[max]) {
            max = left;
        }
        if (right < n && tree[right] > tree[max]) {
            max = right;
        }

        if (max != i) {
            // swap
            int temp = tree[i];
            tree[i] = tree[max];
            tree[max] = temp;

            // 递归
            heapify(tree, n, max);
        }
    }
}

```

这个视频讲得很透彻 [B站视频](https://www.bilibili.com/video/BV1Eb41147dK)