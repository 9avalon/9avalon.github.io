---
title: (Hard)数据流的中位数
date: 2020-03-09 23:28:44
collection: 堆
---

```txt
中位数是有序列表中间的数。如果列表长度是偶数，中位数则是中间两个数的平均值。

例如，

[2,3,4] 的中位数是 3

[2,3] 的中位数是 (2 + 3) / 2 = 2.5

设计一个支持以下两种操作的数据结构：

void addNum(int num) - 从数据流中添加一个整数到数据结构中。
double findMedian() - 返回目前所有元素的中位数。
示例：

addNum(1)
addNum(2)
findMedian() -> 1.5
addNum(3) 
findMedian() -> 2
进阶:

如果数据流中所有整数都在 0 到 100 范围内，你将如何优化你的算法？
如果数据流中 99% 的整数都在 0 到 100 范围内，你将如何优化你的算法？
```

自己题解:

```java
/**
 * @author Miguel.hou
 * @version v1.0
 * @date 2020-03-09
 */
class MedianFinder {

    List<Integer> list = new ArrayList();

    /** initialize your data structure here. */
    public MedianFinder() {

    }

    public void addNum(int num) {
        if (list.size() == 0) {
            list.add(num);
            return;
        }

        // 二分搜索数字要插入的地方
        int left = 0;
        int right = list.size() - 1;

        while (left <= right) {
            int mid = (left + right) / 2;
            if (list.get(mid) == num) {
                // 命中，直接替换
                modify(mid, num);
                return;
            } else if (num > list.get(mid)) {
                left = mid + 1;
            } else if (num < list.get(mid)) {
                right = mid - 1;
            }
        }

        modify(right + 1, num);
    }

    private void modify(int pos , int num) {
        for (int i=list.size() - 1; i >= pos; i--) {
            if (i + 1 == list.size()) {
                list.add(i + 1, list.get(i));
            } else {
                list.set(i+1, list.get(i));
            }
        }

        if (pos == list.size()) {
            list.add(pos, num);
        } else {
            list.set(pos, num);
        } 
    }

    public double findMedian() {
        //1,2,3,4,5,6
        if (list.size() == 0) {
            return 0;
        }
        return list.size() % 2 == 0 ? (list.get(list.size()/2 - 1) + list.get(list.size()/ 2))/(double) 2 : (double)list.get(list.size()/2);
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * MedianFinder obj = new MedianFinder();
 * obj.addNum(num);
 * double param_2 = obj.findMedian();
 */
```

分析: 这题官方题解是用两个堆去处理，我偷懒，看了题解后用了二分搜索+插入排序的做法，结果出来的时间比堆排序慢了10倍。。而且还花了将近两个小时来写。。边界条件太多了，写起来一堆bug，鉴于这题是hard难度，面试可能很难会遇到，就不二刷了，知道大概的思路，就ok。用两个堆来处理！
