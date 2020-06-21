---
title: (Medium)合并区间
date: 2020-06-21 20:12:08
collection: 字符串
---

```txt
给出一个区间的集合，请合并所有重叠的区间。

示例 1:

输入: [[1,3],[2,6],[8,10],[15,18]]
输出: [[1,6],[8,10],[15,18]]
解释: 区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].
示例 2:

输入: [[1,4],[4,5]]
输出: [[1,5]]
解释: 区间 [1,4] 和 [4,5] 可被视为重叠区间。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/merge-intervals
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

```java
class Solution {

    class Node {
        Integer value;
        Integer mark;
        public Node(Integer value, Integer mark) {
            this.value = value;
            this.mark = mark;
        }
    }

    public int[][] merge(int[][] intervals) {
        // start:17:02 end 20:12
        List<Node> list = new ArrayList<>();
        for (int i=0; i<intervals.length; i++) {
            Node left = new Node(intervals[i][0], 0);
            list.add(left);

            Node right = new Node(intervals[i][1], 1);
            list.add(right);
        }

        list.sort((a, b) -> {
            return a.value.compareTo(b.value);
        });

        Integer start = null;
        List<List<Integer>> ret = new ArrayList<>();
        Stack<Integer> stack = new Stack<>();
        for (int i=0; i<list.size(); i++) {
            Node node = list.get(i);
            // 开区间
            if (node.mark == 0) {
                stack.push(node.mark);
                if (start == null) {
                    start = node.value;
                }
                continue;
            }
            if (node.mark == 1) {
                if (i + 1 <= list.size() - 1 && list.get(i).value.compareTo(list.get(i+1).value) == 0  && list.get(i).mark == 1 && list.get(i+1).mark == 0) {
                    i ++;
                    continue;
                }
                stack.pop();
                if (stack.size() == 0) {
                    ret.add(Arrays.asList(start, node.value));
                    start = null;
                }
            }
        }

        // 转换，输出结果
        int[][] r = new int[ret.size()][2];
        for (int i=0; i<ret.size(); i++){
            List<Integer> temp = ret.get(i);
            r[i][0] = temp.get(0);
            r[i][1] = temp.get(1);
        }
        return r;
    }
}
```

分析: 这题就我自己而言，用jdk自带的对象排序，才比较好做。但是时间效率很低很低。

