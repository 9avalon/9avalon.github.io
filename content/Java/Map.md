---
title : Map和Set
date : 2020-04-02 01:05:02
collection : 集合类型
---

## LinkedHashMap

1.双向链表 + HashMap

2.实现按顺序存储，或者按访问顺序存储

3.可以实现LRU，实现LRU的方式为，构造方法设置按访问顺序排序，同时重写当移除元素的方法

4.默认按插入的顺序排序，如果需要遍历，可以直接从头结点开始进行遍历

## TreeMap

1.红黑树实现

2.查询效率比hashmap要慢，因为红黑树其实是基于二分查找的。

## WeakHashMap

1.弱引用，适合用于缓存

## HashSet

1.底层是用HashMap实现，value都是一样的

2.无序

3.key可以为null

4.HashSet没有get方法

## LinkedHashSet

底层基于LinkedHashMap，只是value固定了而已。

## TreeSet

底层基于TreeMap，红黑树