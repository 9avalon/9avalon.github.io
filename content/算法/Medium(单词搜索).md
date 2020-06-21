---
title: (Medium)单词搜索
date: 2020-06-22 01:03:49
collection: DFS
---

```txt
给定一个二维网格和一个单词，找出该单词是否存在于网格中。

单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。

 

示例:

board =
[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]

给定 word = "ABCCED", 返回 true
给定 word = "SEE", 返回 true
给定 word = "ABCB", 返回 false
 

提示：

board 和 word 中只包含大写和小写英文字母。
1 <= board.length <= 200
1 <= board[i].length <= 200
1 <= word.length <= 10^3

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/word-search
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public boolean exist(char[][] board, String word) {
        //start=00:25
        for (int i=0; i<board.length; i++) {
            for (int j=0; j<board[i].length; j++) {
                if (board[i][j] != word.charAt(0)) {
                    continue;
                }
                boolean ret = find(board, word.toCharArray(), 0, i, j, new HashSet<>());
                if (ret) {
                    return ret;
                }
            }
        }
        return false;
    }

    private boolean find(char[][] board, char[] charArray, int wordIndex, int x, int y, Set<String> set) {
        if (x < 0 || y < 0 || x >= board.length || y >= board[x].length) {
            return false;
        }

        if (set.contains(x + "-" + y)) {
            return false;
        }


        if (board[x][y] != charArray[wordIndex]) {
            return false;
        }

        if (wordIndex == charArray.length - 1) {
            return true;
        }

        set.add(x + "-" + y);

        boolean right = find(board, charArray, wordIndex + 1, x, y+1, set);
        if (right) {
            return true;
        }

        boolean down = find(board, charArray, wordIndex + 1, x+1, y, set);
        if (down) {
            return true;
        }

        boolean left = find(board, charArray, wordIndex + 1, x, y-1, set);
        if (left) {
            return true;
        }

        boolean up = find(board, charArray, wordIndex + 1, x-1, y, set);
        if (up) {
            return true;
        }

        set.remove(x + "-" + y);
        return false;
    }
}
```

分析: 回溯解决，这里的set可以用数组来优化，这样效率应该可以继续向上提升。
