---
title: (Medium)电话号码的字母组合
date: 2020-06-20 15:55:02
collection: 回溯法
---

```txt
给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。

给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。



示例:

输入："23"
输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
说明:
尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/letter-combinations-of-a-phone-number
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
```

题解:

```java
class Solution {
    public List<String> letterCombinations(String digits) {
        if (digits.length() == 0) {
            return new ArrayList<>();
        }

        List<String> str = new ArrayList<>();
        for (int i=0; i< digits.length(); i++) {
            if (digits.charAt(i) == '2') {
                str.add("abc");
            } else if (digits.charAt(i) == '3') {
                str.add("def");
            } else if (digits.charAt(i) == '4') {
                str.add("ghi");
            } else if (digits.charAt(i) == '5') {
                str.add("jkl");
            } else if (digits.charAt(i) == '6') {
                str.add("mno");
            } else if (digits.charAt(i) == '7') {
                str.add("pqrs");
            } else if (digits.charAt(i) == '8') {
                str.add("tuv");
            } else if (digits.charAt(i) == '9') {
                str.add("wxyz");
            } else if (digits.charAt(i) == '1') {
                str.clear();
                break;
            }
        }

        List<String> ret = new ArrayList<>();

        loop(str, 0, "", ret);
        return ret;
    }

    private void loop(List<String> str, Integer index, String sb, List<String> ret) {
        if (index >= str.size()) {
            ret.add(sb);
            return;
        }

        String s = str.get(index);
        for (int i=0; i<s.length(); i++) {
            loop(str, index+1, sb + s.charAt(i), ret);
        }
    }
}
```

分析: 回溯法
