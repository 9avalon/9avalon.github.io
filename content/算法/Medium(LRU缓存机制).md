---
title: Medium(LRU缓存机制)
date: 2019-11-22 01:43:35
collection: 常见算法
---

```txt
运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。

获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
写入数据 put(key, value) - 如果密钥已经存在，则变更其数据值；如果密钥不存在，则插入该组「密钥/数据值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。

 

进阶:

你是否可以在 O(1) 时间复杂度内完成这两种操作？

示例:

LRUCache cache = new LRUCache( 2 /* 缓存容量 */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // 返回  1
cache.put(3, 3);    // 该操作会使得密钥 2 作废
cache.get(2);       // 返回 -1 (未找到)
cache.put(4, 4);    // 该操作会使得密钥 1 作废
cache.get(1);       // 返回 -1 (未找到)
cache.get(3);       // 返回  3
cache.get(4);       // 返回  4

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/lru-cache
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

Least Frequently Used 😆

简单原理和实现参考: [漫画：什么是LRU算法](https://mp.weixin.qq.com/s?__biz=MzIxMjE5MTE1Nw==&mid=2653195947&idx=1&sn=2954871ed1195dd3ebab0c9691e674b4&chksm=8c99fc71bbee7567c29169a86b4a2133bf87492ce5d2b7c9fdaf7740d2fc01084670b75e976a&scene=21#wechat_redirect)

## 简单版本

可以使用JDK自带的`LinkedHashMap`数据结构来实现

方法说明

```java

//LinkedHashMap的一个构造函数，当参数accessOrder为true时，即会按照访问顺序排序，最近访问的放在最前，最早访问的放在后面
public LinkedHashMap(int initialCapacity, float loadFactor, boolean accessOrder) {
        super(initialCapacity, loadFactor);
        this.accessOrder = accessOrder;
}

//LinkedHashMap自带的判断是否删除最老的元素方法，默认返回false，即不删除老数据
//我们要做的就是重写这个方法，当满足一定条件时删除老数据
protected boolean removeEldestEntry(Map.Entry<K,V> eldest) {
        return false;
}
```

实现方式

```java
final int cacheSize = 100;
Map<String, String> map = new LinkedHashMap<String, String>((int) Math.ceil(cacheSize / 0.75f) + 1, 0.75f, true) {
    @Override
    protected boolean removeEldestEntry(Map.Entry<String, String> eldest) {
        // 这是的意思是，当map里面元素大于我们设定的大小(100)时，就会执行这个逻辑
        return size() > cacheSize;
    }
};
```

## 手写版本

```java
class LRUCache {

    private Node head;
    private Node tail;
    private Map<Integer, Node> map;
    private Integer capacity;

    public LRUCache(int capacity) {
        this.capacity = capacity;
        map = new HashMap<>();
    }

    public int get(int key) {
        Node node = map.get(key);
        if (node == null) {
            return -1;
        }

        refreshNode(node);
        return node.value;
    }

    public void put(int key, int value) {
        Node node = map.get(key);
        if (node == null) {
            if (map.size() >= capacity) {
                Integer removeKey = removeNode(head);
                map.remove(removeKey);
            } 
            // 加入队列
            Node newNode = new Node(key, value);
            addNode(newNode);
            map.put(key, newNode);
        } else {
            node.value = value;
            refreshNode(node);
        }
    }

    private void refreshNode(Node node) {
        if (node == tail) {
            return;
        }

        // 移除节点
        removeNode(node);
        // 新增节点
        addNode(node);
    }

    private void addNode(Node node) {
        if (tail != null) {
            tail.next = node;
            node.pre = tail;
            node.next = null;
        }
        tail = node;
        if (head == null) {
            head = node;
        }
    }

    private Integer removeNode(Node node) {
        if (node == tail) {
            tail = node.pre;
            if (node.pre != null) {
                node.pre.next = null;
            }
        } else if (node == head) {
            head = node.next;
            if (node.next != null) {
                node.next.pre = null;
            }
        } else {
            node.pre.next = node.next;
            node.next.pre = node.pre;
        }
        return node.key;
    }

    public class Node {
        Integer key;
        Integer value;
        Node next;
        Node pre;

        public Node(Integer key, Integer value){
            this.key = key;
            this.value = value;
            next = null;
            pre = null;
        }
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
```

2020-06-15新写了一版，这版给头节点和尾节点都加了一个虚拟节点，这样就可以不用处理各种空值问题，方便了非常多。

```java
class LRUCache {
    class Node {
        int key;
        int value;

        Node pre;
        Node next;

        public Node(int key, int value) {
            this.key = key;
            this.value = value;
            pre = null;
            next = null;
        }
    }

    private Node head;
    private Node tail;
    private int capacity;
    private Map<Integer, Node> map;

    public LRUCache(int capacity) {
        head = new Node(0, 0);
        tail = new Node(0, 0);
        head.next = tail;
        tail.pre = head;
        map = new HashMap<>();
        this.capacity = capacity;
    }

    public int get(int key) {
        Node node = map.get(key);
        if (node == null) {
            return -1;
        }

        refreshNode(node);
        return node.value;
    }

    public void put(int key, int value) {
        Node node = map.get(key);
        if (node == null) {
            if (map.size() == capacity) {
                Node remove = removeNode(tail.pre);
                map.remove(remove.key);
            }

            Node newNode = new Node(key, value);
            addNode(newNode);
            map.put(key, newNode);
        } else {
            node.value = value;
            refreshNode(node);
        }
    }

    private void refreshNode(Node node) {
        removeNode(node);
        addNode(node);
    }

    private Node removeNode(Node node) {
        node.pre.next = node.next;
        node.next.pre = node.pre;
        return node;
    }

    private void addNode(Node node) {
        Node temp = head.next;
        head.next = node;
        temp.pre = node;
        node.next = temp;
        node.pre = head;
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
```