---
title: volatile
date: 2016-8-17 21:44:09
collection: JavaSE
---

最近读《并发编程实战》的时候，或多或少地接触到了volatile这个关键字，但是一直都不是很清楚这个关键字到底是用来干啥的。现在就结合百度来解释一下这个关键字。


volatile的作用是，作为指令关键字，确保本指令条不会因为编译器优化而省略，而且要求每次直接读值。

比如单例模式中的双重校验锁

```java
public class Single {
    private static Single single;

    private Single() {}

    public static Single getSingle() {
        if (null == single) {
            synchronized (Single.class) {
                if (null == single) {
                    single = new Single();
                }
            }
        }
        return single;
    }
}
```

> 这段代码看起来很完美，很可惜，它是有问题。主要在于single=new Single()这句，这并非是一个原子操作，事实上在 JVM 中这句话大概做了下面 3 件事情。
>
> 1、给 single 分配内存
>
> 2、调用 Single的构造函数来初始化成员变量
>
> 3、将single对象指向分配的内存空间（执行完这步 single 就为非 null 了）
>
> 但是在 JVM 的即时编译器中存在指令重排序的优化。也就是说上面的第二步和第三步的顺序是不能保证的，最终的执行顺序可能是 1-2-3 也可能是 1-3-2。如果是后者，则在 3 执行完毕、2 未执行之前，被线程二抢占了，这时 single 已经是非 null 了（但却没有初始化），所以线程二会直接返回 single，然后使用，然后顺理成章地报错。

所以为了防止jvm的“优化”，我们会给变量加上volatile关键字，告诉jvm这个变量你得小心翼翼的，不要搞优化。

```
private volatile static Single single;
```



一旦一个共享变量（类的成员变量、类的静态成员变量）被volatile修饰之后，那么就具备了两层语义：

1）保证了不同线程对这个变量进行操作时的可见性，即一个线程修改了某个变量的值，这新值对其他线程来说是立即可见的。

2）禁止进行指令重排序。



####  参考

下面这篇文章写得非常好，强烈推荐。。。虽然有个例子解释地不是很清楚。。。但是只要记住这一点，volatile不能保持原子性，但能保证可见性和禁止指令重排序就好了。

[Java并发编程，volatile解析](http://www.cnblogs.com/dolphin0520/p/3920373.html])





