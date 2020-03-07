---
title: (Medium)实现Trie前缀树
date: 2020-03-07 17:50:43
collection: 字符串
---

```txt
实现一个 Trie (前缀树)，包含 insert, search, 和 startsWith 这三个操作。

示例:

Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // 返回 true
trie.search("app");     // 返回 false
trie.startsWith("app"); // 返回 true
trie.insert("app");
trie.search("app");     // 返回 true
说明:

你可以假设所有的输入都是由小写字母 a-z 构成的。
保证所有输入均为非空字符串。
```

自己题解:

```java
class Trie {

    private Trie[] children = new Trie[26];
    private boolean isEnd = false;

    /** Initialize your data structure here. */
    public Trie() {

    }

    /** Inserts a word into the trie. */
    public void insert(String word) {
        Trie temp = this;
        for (int i=0; i<word.length(); i++) {
            if (temp.children[word.charAt(i) - 'a'] == null) {
                temp.children[word.charAt(i) - 'a'] = new Trie();
            }
            temp = temp.children[word.charAt(i) - 'a'];
        }
        temp.isEnd = true;
    }

    /** Returns if the word is in the trie. */
    public boolean search(String word) {
        Trie temp = this;
        for (int i=0; i<word.length(); i++) {
            if (temp.children[word.charAt(i) - 'a'] == null) {
                return false;
            }
            temp = temp.children[word.charAt(i) - 'a'];
        }
        return temp.isEnd;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    public boolean startsWith(String prefix) {
        Trie temp = this;
        for (int i=0; i<prefix.length(); i++) {
            if (temp.children[prefix.charAt(i) - 'a'] == null) {
                return false;
            }
            temp = temp.children[prefix.charAt(i) - 'a'];
        }
        return true;
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * Trie obj = new Trie();
 * obj.insert(word);
 * boolean param_2 = obj.search(word);
 * boolean param_3 = obj.startsWith(prefix);
 */
```

分析:

1. 害，看起来挺难，做起来挺简单，背就完事了。
