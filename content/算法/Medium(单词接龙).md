---
title: (Medium)单词接龙
date: 2020-05-10 22:45:49
collection: 图
---

```txt
给定两个单词（beginWord 和 endWord）和一个字典，找到从 beginWord 到 endWord 的最短转换序列的长度。转换需遵循如下规则：

每次转换只能改变一个字母。
转换过程中的中间单词必须是字典中的单词。
说明:

如果不存在这样的转换序列，返回 0。
所有单词具有相同的长度。
所有单词只由小写字母组成。
字典中不存在重复的单词。
你可以假设 beginWord 和 endWord 是非空的，且二者不相同。
示例 1:

输入:
beginWord = "hit",
endWord = "cog",
wordList = ["hot","dot","dog","lot","log","cog"]

输出: 5

解释: 一个最短转换序列是 "hit" -> "hot" -> "dot" -> "dog" -> "cog",
     返回它的长度 5。
示例 2:

输入:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log"]

输出: 0

解释: endWord "cog" 不在字典中，所以无法进行转换。
```

题解:

```java
class Solution {
    public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        // 构造邻接表,key为word，map为相邻的
        Map<String, List<String>> map = new HashMap<>();
        for (String word : wordList) {
            for (int i=0; i<word.length(); i++) {
                // hot i=1, h+*+t
                String newWord = word.substring(0, i) + '*' + word.substring(i + 1, word.length());
                List<String> list = map.getOrDefault(newWord, new ArrayList<>());
                list.add(word);
                map.put(newWord, list);
            }
        }

        Map<String, Boolean> visited = new HashMap<>();
        visited.put(beginWord, true);

        Queue<Pair<String,Integer>> queue = new LinkedList<>();
        queue.add(new Pair(beginWord, 1));

        while (!queue.isEmpty()) {
            Pair<String, Integer> node = queue.poll();
            String word = node.getKey();
            Integer level = node.getValue();

            for (int i=0; i<word.length(); i++) {
                String newWord = word.substring(0, i) + '*' + word.substring(i + 1, word.length());
                for (String mWord : map.getOrDefault(newWord, new ArrayList<>())) {
                    if (Objects.equals(mWord, endWord)) {
                        return level + 1;
                    }

                    if (!visited.containsKey(mWord)) {
                        visited.put(mWord, true);
                        queue.add(new Pair(mWord, level + 1));
                    }

                }
            }
        }
        return 0;
    }
}
}
```

分析: 这题抄答案了，写起来比较复杂，基本思路是构造邻接表，然后使用BFS来找出最短路径。
