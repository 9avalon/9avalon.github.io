---
title: (Hard)单词搜索 II
date: 2020-02-08 12:54:25
collection: DFS
---

```txt
给定一个二维网格 board 和一个字典中的单词列表 words，找出所有同时在二维网格和字典中出现的单词。

单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母在一个单词中不允许被重复使用。

示例:

输入: 
words = ["oath","pea","eat","rain"] and board =
[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]

输出: ["eat","oath"]
说明:
你可以假设所有输入都由小写字母 a-z 组成。

提示:

你需要优化回溯算法以通过更大数据量的测试。你能否早点停止回溯？
如果当前单词不存在于所有单词的前缀中，则可以立即停止回溯。什么样的数据结构可以有效地执行这样的操作？散列表是否可行？为什么？ 前缀树如何？如果你想学习如何实现一个基本的前缀树，请先查看这个问题： 实现Trie（前缀树）。
```

自己题解:

```java
class Solution {

    private Solution[] children = new Solution[26];
    private boolean isEnd = false;

    public List<String> findWords(char[][] board, String[] words) {
        // 初始化前缀树
        for (String s : words) {
            insert(s);
        }

        List<String> res = new ArrayList();

        for (int y=0; y<board.length; y++) {
            for (int x=0; x<board[y].length; x++) {
                dfs("", y, x, board, words, res, new ArrayList());
            }
        }
        return res;
    }

    private void dfs(String temp, int y, int x, char[][] board, String[] words, List<String> res, List<String> road) {
        if (y >= board.length || y < 0 || x < 0 || x >= board[y].length) {
            return;
        }

        temp += board[y][x];
        if (!startsWith(temp) || road.contains(y + "-" + x)) {
            return;
        }

        if (search(temp) && !res.contains(temp)) {
            res.add(temp);
        }

        road.add(y + "-" + x);
        dfs(temp, y-1, x, board, words, res, road); // 上
        dfs(temp, y+1, x, board, words, res, road); // 下
        dfs(temp, y, x-1, board, words, res, road); // 左
        dfs(temp, y, x+1, board, words, res, road); // 右 
        road.remove(road.size() - 1);
    }

    /** Inserts a word into the trie. */
    public void insert(String word) {
        Solution temp = this;
        for (int i=0; i<word.length(); i++) {
            if (temp.children[word.charAt(i) - 'a'] == null) {
                temp.children[word.charAt(i) - 'a'] = new Solution();
            }
            temp = temp.children[word.charAt(i) - 'a'];
        }
        temp.isEnd = true;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    public boolean startsWith(String prefix) {
        Solution temp = this;
        for (int i=0; i<prefix.length(); i++) {
            if (temp.children[prefix.charAt(i) - 'a'] == null) {
                return false;
            }
            temp = temp.children[prefix.charAt(i) - 'a'];
        }
        return true;
    }

    public boolean search(String word) {
        Solution temp = this;
        for (int i=0; i<word.length(); i++) {
            if (temp.children[word.charAt(i) - 'a'] == null) {
                return false;
            }
            temp = temp.children[word.charAt(i) - 'a'];
        }
        return temp.isEnd;
    }
}
```

分析:

提交了好多好多次，需要注意的点有

1.实现前缀树，以快速剪枝

2.要记录每一步dfs的值，避免死循环dfs
