---
title : (Easy)设计哈希映射
date: 2020-06-04 12:05:03
collection : 哈希表
---

### 题目描述

```txt

不使用任何内建的哈希表库设计一个哈希映射

具体地说，你的设计应该包含以下的功能

put(key, value)：向哈希映射中插入(键,值)的数值对。如果键对应的值已经存在，更新这个值。
get(key)：返回给定的键所对应的值，如果映射中不包含这个键，返回-1。
remove(key)：如果映射中存在这个键，删除这个数值对。

示例：

MyHashMap hashMap = new MyHashMap();
hashMap.put(1, 1);
hashMap.put(2, 2);
hashMap.get(1);            // 返回 1
hashMap.get(3);            // 返回 -1 (未找到)
hashMap.put(2, 1);         // 更新已有的值
hashMap.get(2);            // 返回 1 
hashMap.remove(2);         // 删除键为2的数据
hashMap.get(2);            // 返回 -1 (未找到) 

注意：

所有的值都在 [0, 1000000]的范围内。
操作的总数目在[1, 10000]范围内。
不要使用内建的哈希库。
```

```java
class MyHashMap {

    private int capacity;
    private Node[] table;

    class Node {
        int key;
        int value;
        Node next;

        public Node(int key, int value) {
            this.key = key;
            this.value = value;
            this.next = null;
        }
    }

    /** Initialize your data structure here. */
    public MyHashMap() {
        capacity = 1000000;
        table = new Node[capacity];
    }

    /** value will always be non-negative. */
    public void put(int key, int value) {
        int index = key % (capacity - 1);
        Node node = table[index];
        if (node == null) {
            table[index] = new Node(key, value);
            return;
        } else {
            // 链表不为空，遍历链表，尾插
            Node tail = null;
            while (node != null) {
                if (node.key == key) {
                    // 覆盖更新
                    node.value = value;
                    return;
                }
                tail = node;
                node = node.next;
            }

            // 尾插法插入
            Node newNode = new Node(key, value);
            tail.next = newNode;
        }
    }

    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
    public int get(int key) {
        int index = key % (capacity - 1);
        Node node = table[index];

        while (node != null) {
            if (node.key == key) {
                return node.value;
            }
        }

        return -1;
    }

    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
    public void remove(int key) {
        int index = key % (capacity - 1);
        Node node = table[index];

        // fake head
        Node head = new Node(0, 0);
        head.next = node;

        Node p = head;
        while (p.next != null) {
            if (p.next.key == key) {
                p.next = p.next.next;
                break;
            }
            p = p.next;
        }

        table[index] = head.next;
    }
}

/**
 * Your MyHashMap object will be instantiated and called as such:
 * MyHashMap obj = new MyHashMap();
 * obj.put(key,value);
 * int param_2 = obj.get(key);
 * obj.remove(key);
 */
```

分析：一开始用拉链法，只开了10000的容量，结果碰撞超时了。。后面直接扩大了100倍，秒过。。。什么，你说面试的时候要写自动扩容？
