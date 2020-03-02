---
title: (Easy)打乱数组
date: 2020-03-02 22:50:28
collection: 设计问题
---

```txt
// 以数字集合 1, 2 和 3 初始化数组。
int[] nums = {1,2,3};
Solution solution = new Solution(nums);

// 打乱数组 [1,2,3] 并返回结果。任何 [1,2,3]的排列返回的概率应该相同。
solution.shuffle();

// 重设数组到它的初始状态[1,2,3]。
solution.reset();

// 随机返回数组[1,2,3]打乱后的结果。
solution.shuffle();
```

自己题解:

```java
class Solution {

    private int[] originArray;
    private int[] shuffleArray;

    public Solution(int[] nums) {
        if (nums.length == 0) {
            originArray = nums;
            shuffleArray = nums;
            return;
        }

        originArray = nums;
        shuffleArray = new int[nums.length];
        for (int i=0; i<nums.length; i++) {
            shuffleArray[i] = nums[i];
        }
    }

    /** Resets the array to its original configuration and return it. */
    public int[] reset() {
        return originArray;
    }

    /** Returns a random shuffling of the array. */
    public int[] shuffle() {
        if (shuffleArray.length == 0) {
            return shuffleArray;
        }

        Random random = new Random();

        for (int i=0; i<shuffleArray.length; i++) {
            int num1 = random.nextInt(shuffleArray.length);
            int num2 = random.nextInt(shuffleArray.length);

            if (num1 == num2) {
                continue;
            }

            int temp = shuffleArray[num2];
            shuffleArray[num2] = shuffleArray[num1];
            shuffleArray[num1] = temp;
        }

        return shuffleArray;
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(nums);
 * int[] param_1 = obj.reset();
 * int[] param_2 = obj.shuffle();
 */
```

分析: 洗牌算法，我的思路是从第一个开始，做随机交换，看了评论区的题解，比较经典的做法是随机从数组中取一个数，然后放到新数组中，达到洗牌的目的。
