---
title : 多线程循环打印ABC
date : 2016-12-11 13:48:22
---

据说是迅雷的原题目，题目要求是，用三个线程按顺序循环打印abc三个字母，比如abcabcabc
用sync或者lock解决

## Sync

```java
public class ForEachPrint implements Runnable {
    private static Object lockObj = new Object();

    private String printCode;
    private int printNum;

    public ForEachPrint(String printCode, int printNum) {
        this.printCode = printCode;
        this.printNum = printNum;
    }

    @Override
    public void run() {
        while (ForEachPrintDemo.count < 30) {
            synchronized (lockObj) {
                try {
                    if (ForEachPrintDemo.count % 3 == printNum - 1) {
                        System.out.print(printCode);
                        ForEachPrintDemo.count ++;
                        lockObj.notifyAll();
                    } else {
                        lockObj.wait();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
```

## Lock

```java
public class ForEachPrint implements Runnable {
    private static Lock lock = new ReentrantLock();
    private static Condition condition = lock.newCondition();

    private String printCode;
    private int printNum;

    public ForEachPrint(String printCode, int printNum) {
        this.printCode = printCode;
        this.printNum = printNum;
    }

    @Override
    public void run() {
        while (ForEachPrintDemo.count < 30) {
            lock.lock();
            try {
                if (ForEachPrintDemo.count % 3 == printNum - 1) {
                    System.out.print(printCode);
                    ForEachPrintDemo.count++;
                    condition.signalAll();
                } else {
                    condition.await();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                lock.unlock();
            }
        }
    }
}
```

```java
public class ForEachPrintDemo {
    public  static  Integer count = 0;

    public static void main(String[] args) {
        Thread threadA = new Thread(new ForEachPrint("A", 1));
        Thread threadB = new Thread(new ForEachPrint("B", 2));
        Thread threadC = new Thread(new ForEachPrint("C", 3));

        threadA.start();
        threadB.start();
        threadC.start();
    }
}
```