---
title: LRU
date: 2019-11-22 01:43:35
collection: 常见算法
---

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
    return size() > cacheSize;
    }
};
```

## 手写版本

```java
/**
 * LRU缓存实现
 *
 * @author Miguel.hou
 * @version v1.0
 * @date 2019-11-22
 */
public class LRUCache<V> {

    private Node<V> head;
    private Node<V> tail;
    private HashMap<String, Node<V>> hashMap;

    private Integer capacity;

    public LRUCache(Integer capacity) {
        if (capacity <= 0) {
            throw new IllegalArgumentException("capacity must greater than 0");
        }
        this.capacity = capacity;
        hashMap = new HashMap<>();
    }

    public synchronized V get(String key) {
        Node<V> node = hashMap.get(key);
        if (node == null) {
            return null;
        }

        // 刷新节点
        refreshNode(node);
        return node.value;
    }

    public synchronized void put(String key, V value) {
        Node<V> node = hashMap.get(key);
        if (node == null) {
            // 判断是否大于容量，需要去除首节点
            if (hashMap.size() >= capacity) {
                String rmKey = removeNode(head);
                hashMap.remove(rmKey);
            }
            // 加入队列
            Node<V> newNode = new Node<>(key, value);
            addNode(newNode);
            hashMap.put(key, newNode);
        } else {
            // node存在，刷新值
            node.value = value;
            refreshNode(node);
        }
    }

    public synchronized void remove(String key) {
        Node<V> node = hashMap.get(key);
        if (node == null) {
            return;
        }
        removeNode(node);
        hashMap.remove(key);
    }

    /**
     * 刷新节点位置
     * @param node
     */
    private void refreshNode(Node<V> node) {
        if (node == tail) {
            // 尾节点，不需要更新节点
            return;
        }

        // 删除节点
        removeNode(node);
        // 新增节点
        addNode(node);
    }

    private void addNode(Node<V> node) {
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

    private String removeNode(Node<V> node) {
        if (node == tail) {
            tail = node.pre;
        } else if (node == head) {
            head = node.next;
        } else {
            node.pre.next = node.next;
            node.next.pre = node.pre;
        }

        return node.key;
    }

    class Node<V> {
        public Node(String key, V value) {
            this.key = key;
            this.value = value;
        }

        Node<V> pre;
        Node<V> next;
        String key;
        V value;
    }

    public static void main(String[] args) {
        LRUCache<String> lruCache = new LRUCache<>(3);

        lruCache.put("001", "用户1信息");
        lruCache.put("002", "用户2信息");
        lruCache.put("003", "用户3信息");
        lruCache.put("004", "用户4信息");
        lruCache.put("005", "用户5信息");

        System.out.println(lruCache.get("004"));
        System.out.println(lruCache.get("003"));
        System.out.println(123);
    }
}
```

