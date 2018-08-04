---
title: Java并发专题
date: 2016-8-7 14:52
update: 2018-07-14 11:36
---

[TOC]

# 导读

* Java并发基础
* 并发锁
* 原子操作类
* 常见的并发工具类

# Java并发基础

## 什么是线程安全

当多个线程并发访问一个类、方法或对象时，如果该类始终能正确执行，得到正确的结果，则该方法就是线程安全的。

## 串行和并行

并行不一定比串行快，因为线程有创建和上下文切换的开销。会有临界点。

# 常见锁

## volatile

volatile，比 synchronized更轻量级的实现，它保证了并发时，共享变量的可见性，即，一个线程修改了变量，另一个线程能读到这个修改的值，但是，它不能保证操作的 **原子性** 。

共享变量：可以看到，线程一般先从主内存中把变量取出，然后复制一个变量副本到本地内存中。再进行操作，如果变量被声明了volatile，则每次这个值的修改，都会使本地内存的副本失效，线程需要从主内存中重新获取值。即声明了volatile的变量可以使值是内存中最新的值。

![共享变量](http://ww4.sinaimg.cn/large/005H7Wvyjw1f9pdmcjay2j30cs0avgmy.jpg)

## synchronized

synchronized在java6之前很多人都称呼其为“重量级锁”，但是随着java后面的持续优化，synchronized的性能已经比以前有了很大的提升。

synchronized是对象锁，如果类中两个方法都是被synchronized修饰，当并发访问时，会互相等待。

synchronized有好几种用法

1.给方法加

```java
public synchronized void sum() {
    dosomething();
}
```

加锁后，同一个实例，多个线程并发时，只有一个线程能进入该方法并执行

2.给静态方法加

```java
public static synchronized void sum() {
    dosomething();
}
```

加锁后，所有实例，多个线程并发时，都只有一个线程能进入该方法并执行

3.方法体中加入

synchronized()里面既可以传类，也可以传实例，传类就是类锁，传实例就是对象锁。如下面的代码例子，若分别使用类锁和对象锁，两者是不会互相阻塞的。

```java
public class Entity {
    ......
}

public void test() {
    synchronized (Entity.class) {
        dosomething();
    }

    synchronized (new Entity()) {
        dosomething();
    }
}
```

## ReenTranLock

也是一种常见的并发控制锁，比syncronized灵活，可以控制的粒度更小。

```java
public class ReenTranLockDemo {

    private static ReentrantLock reentrantLock = new ReentrantLock();

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            new Thread(new Runnable() {
                public void run() {
                    reentrantLock.lock();

                    System.out.println("执行业务中........." + new Date());

                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                    }

                    reentrantLock.unlock();
                }
            }).start();
        }
    }
}
```

输出如下:

```java
执行业务中.........Sun Jul 15 12:22:07 CST 2018
执行业务中.........Sun Jul 15 12:22:08 CST 2018
执行业务中.........Sun Jul 15 12:22:09 CST 2018
执行业务中.........Sun Jul 15 12:22:10 CST 2018
```

## 锁重入

同一个线程，如果已经获取到锁后，要继续获取锁时，可以直接执行，不需要再获取锁。synchronized是支持锁重入的。

# 原子变量类

AtomicIneger，AtomicLong，等等

线程安全，内部有锁，可以作为全局变量来进行内部操作，如自增。

扩展：目前项目中一般很少用到原子变量类，因为现在我们的程序一般都是分布式了，几乎不会单机跑，而分布式，我们一般使用redis来作为自增锁来使用。

# 常见的并发工具类

## CountDownLatch

CountDownLatch可以实现类似倒计时的功能，通过调用 **countDown** 来实现减一的功能，当CountDownLatch里面的计数器减到0时，之前await挂起的线程，就能继续执行。

```java
public class CountDownLatchDemo {

    public static CountDownLatch countDownLatch = new CountDownLatch(5);

    public static void main(String[] args) throws InterruptedException {
        for (int i = 0; i < 6; i++) {
            final Thread thread = new Thread(new Runnable() {
                public void run() {
                    System.out.println(Thread.currentThread().getId() + "-- 开始");
                    countDownLatch.countDown();

                    try {
                        Thread.sleep(1000L);
                    } catch (InterruptedException e) {
                    }

                    System.out.println(Thread.currentThread().getId() + "-- 结束");
                }
            });
            thread.start();
        }

        System.out.println("主线程等待开始............");
        countDownLatch.await();
        System.out.println("主线程等待结束............");
    }
}
```

执行结果

```java
10-- 开始
11-- 开始
12-- 开始
13-- 开始
14-- 开始
主线程等待开始............
15-- 开始
主线程等待结束............
10-- 结束
11-- 结束
12-- 结束
13-- 结束
14-- 结束
15-- 结束
```

## CyclicBarrier

CyclicBarrier可以应用在这种场景。

任务分发给各个线程执行，各个线程执行完后，主线程再进行统一处理。

在项目中，比如我们在修数据时，要修几百万上千万的数据，需要用多线程跑缩短时间，这时候可以使用CyclicBarrier来帮助我们完成任务

首先在主线程将任务分片，分片完毕后，各个分片的数据交给各个线程执行，执行完毕后，主线程再做逻辑判断，重新分片执行。

```java
public class CyclicBarrierDemo {

    private static CyclicBarrier cyclicBarrier = new CyclicBarrier(3);

    public static void main(String[] args) throws BrokenBarrierException, InterruptedException {
        for (int i=0 ; i<2; i++) {
            Thread thread = new Thread(new Runnable() {
                public void run() {
                    try {
                        Thread.sleep(1000);

                        // dosomething()
                        System.out.println(Thread.currentThread().getId() + "[线程完成作业]");

                        cyclicBarrier.await();
                    } catch (Exception e) {
                    }
                }
            });
            thread.start();
        }

        System.out.println("主线程等待线程作业完成..........");

        cyclicBarrier.await();

        System.out.println("主线程开始作业 =>>>>>>>>>>>>>");
        // dosomething()
    }
}

```

输出结果

```java
主线程等待线程作业完成..........
10[线程完成作业]
11[线程完成作业]
主线程开始作业 =>>>>>>>>>>>>>
```

## Semaphore（信号量）

可以用来控制单机并发，会阻塞。

```java
public class SemaphoreDemo {

    // 初始化容量为2的信号量
    private static Semaphore semaphore = new Semaphore(2);

    /**
     * 只允许两个并发的方法
     */
    public static void acceptTwoThreadMethod() {
        try {
            semaphore.acquire();

            System.out.println("业务执行中.........");
            Thread.sleep(1000L);

            semaphore.release();

        } catch (Exception e) {

        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            Thread thread = new Thread(new Runnable() {
                public void run() {
                    acceptTwoThreadMethod();
                }
            });
            thread.start();
        }
    }
}
```
