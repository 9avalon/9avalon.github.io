---
title: 深入理解JVM虚拟机
date: 2018-07-07 21:05:16
---

[TOC]

## 主要内容

* JVM内存结构
* 类加载机制
* 垃圾回收
* JVM命令行工具使用
* JVM参数调优

## JVM内存结构

### 本地方法栈区

存放native方法

### 程序计数器

可以被看作是当前程序所执行的字节码所在行号的指示器。cpu切换线程时，找到程序计数器指向的字节码，继续执行程序。

### 栈

虚拟机栈的生命周期与线程是一样的，为线程私有的。

每个方法都会产生一个栈帧，里面存放局部变量，变量引用，方法出入口等等。

每个方法从开始被调用到结束调用，就意味着一个栈帧在虚拟机栈中入栈到出栈的过程。

### 堆

存放所有对象的区域，被所有线程共享。

### 方法区

各个线程共享的区域，用于存储已被虚拟机加载的类信息，常量，静态变量等。

运行时常量池也在方法区

别名叫【非堆】，方法区也在堆区。

## 垃圾回收

### 判断对象是否可以被回收

#### 计数法

最简单的一种判断对象是否可回收的方法是计数法，当对象有被引用时，计数器加一，不被引用时，减一，当触发GC时，若计数器为0，则该对象可以被回收。但是，虽然该方法看似简单有效，但是不能解决对象循环依赖的问题。如以下代码:

```java
Object instanceA = new Obj();
Object instanceB = new Obj();
instanceA = instanceB;
instanceB = instanceA;

instanceA = null;
instanceB = null; 

gc()
```

instanceA和instanceB互相引用，计数器不为0，不能被回收。

#### 可达性分析

因此，现在主流的JVM虚拟机是通过 *【可达性分析】* 来判断对象是否可被回收。

![可达性分析](https://ws1.sinaimg.cn/mw690/005H7Wvygy1ft1nak0pz3j31ag0ss7gy.jpg)

那么那些对象可以作为GC Roots呢？

* 栈中引用的对象
* 方法区中静态属性引用的对象
* 方法区中常量引用的对象
* JNI引用的对象

### 垃圾回收算法

#### 标记-清理算法

基本原理，标记需要清除的对象，在标记完成后，进行统一回收。优点是速度快，但是会导致内存区域产生大量不连续的内存碎片，导致后续分配内存时候，容易导致无可用区域块而需要重新分配内存。

#### 复制算法

基本原理，将内存分为两块，GC时候，将需要回收的对象直接清除，不需要回收的对象挪到另外的内存区里面。优点是内存区域整齐，不容易产生小碎片段，但是因为需要划分两块内存，会造成内存浪费。

目前主流的JVM，年轻代回收算法使用的是复制算法，对年轻代分为三个区域，分别为一个eden区和两个suivivor区，eden区与suivivor内存大小比一般为8:1:1，一般年轻代进行回收时，eden区90%的对象都会被回收，没被回收的对象进入suivior区，如果对象两次gc后，还在suivior区，就会进入到老年代里面。

#### 标记-整理算法

因为老年代内存较大，如果按年轻代一样使用复制算法的话，需要划分两块内存，会造成较大的空间浪费。而且老年代里面，对象的存活率较高，复制带来的成本也会变大。所以，老年代一般不使用复制算法。

目前老年代主流的算法为标记整理方法，这个方法是与标记-清理算法不一样的是，先对要清理的对象进行清除，清除完毕后，再将老年代里面的对象进行整理，减少不连续的内存区域。

### 垃圾收集器

#### Serial收集器(新生代)

由JVM后台单独起一个线程(单线程)进行收集回收，此时其他线程都需要停顿。是最原始的收集器。

#### ParNew收集器(新生代)

Serial收集器的多线程版本，提升了效率。配合CMS使用

#### Parallel Old(新生代)

复制方法，配合PS使用，jdk1.8默认

#### Serial Old收集器（老年代）

Serial收集器的老年代版本，不建议使用

#### Parallel Old(老年代)

吞吐量优先，标记-整理算法

#### CMS(老年代)

并发收集，低停顿，基于标记-清除算法，物理分代

1. 初始标记(stop the world)
2. 并发标记
3. 重新标记(stop the world)
4. 并发清除

#### G1（目前最先进）

基于标记-整理算法，逻辑分代，多个Region

1. 初始标记
2. 并发标记
3. 最终标记
4. 筛选回收

jdk1.7正式商用。1.9后默认

#### ZGC

忘了

### JVM命令行工具使用

#### jps

查看虚拟机进程

```shell
jps [options] {hostid}

常用:
jps -v | grep {filter_name}
```

-v 输出虚拟机进程进程启动时的JVM参数

#### jstat

```java
jstat [ option vmid []interval[s|ms] [count] ]

比如，需要250毫秒查询一次进程2764垃圾收集情况，那命令格式为
jstat -gc 2764 250 20

```

```sh
jstat -gcutil pid 1000 1000 #一秒采样一次，共打印1000次

S0：幸存1区当前使用比例
S1：幸存2区当前使用比例
E：伊甸园区使用比例
O：老年代使用比例
M：元数据区使用比例
CCS：压缩使用比例
YGC：年轻代垃圾回收次数
FGC：老年代垃圾回收次数
FGCT：老年代垃圾回收消耗时间
GCT：垃圾回收消耗总时间
```

![jstat执行样例](https://ws1.sinaimg.cn/mw690/005H7Wvygy1ft1rxw4epyj31cw0mmwqt.jpg)

#### jmap

jmap用于生成堆转储快照，我们经常用jamp来获取dump文件，用于分析异常情况。

```shell
jmap [option] vmid

eg.
jmap -dump:format=b,file=filename pid
jmap -dump:format=b,file=srv-account-center-dump.bin 2777
```

#### jstack

用来查看当前线程的快照

```shell
jstack [option] vmid

-l 除堆栈外，显示关于锁的附加信息

```

#### JVM参数配置调优

* -xms,-xmx

堆区最大和最小值，一般为机器内存的1/3或1/4的值。xmn年轻代大，一般xms和xmx一样大小，减少jvm动态扩容导致的消耗

* -xmn

年轻代大小，sun建议为整个堆区的3/8

* -XX:PermSize

持久区大小，存放静态类，常量池等。一般为内存的六十四分之一。10g机器，156m

#### 官方推荐

Java整个堆大小设置，Xmx 和 Xms设置为老年代存活对象的3-4倍，即FullGC之后的老年代内存占用的3-4倍

永久代 PermSize和MaxPermSize设置为老年代存活对象的1.2-1.5倍。

年轻代Xmn的设置为老年代存活对象的1-1.5倍。

老年代的内存大小设置为老年代存活对象的2-3倍。

## 类加载机制

### 类加载流程

加载、验证、准备、解析、初始化、运行、终止。

### 类加载器

Bootstrap ClassLoader-> External ClassLoader -> Application ClassLoader -> User ClassLoader

#### Bootstrap ClassLoader

启动类加载器，加载java lib包下的类

#### Externsion ClassLoader

扩展类加载器，加载lib/ext里面的类

#### Application ClassLoader

应用程序加载器，加载应用程序自己的类

### User ClassLoader

用户自定义加载器

### 双亲委派机制

当一个类加载器收到类加载请求时，会先尝试让父级类加载器加载类，如果父加载器加载不了，才会自行初始化。

为什么要有双亲委派机制：优先级，jdk lib优先加载。解决类冲突。

### 破坏双亲委派机制

自定义类加载器，重写findClass
JNDI,父加载器要找子加载器
OSGI，重写类加载模式。

### 类初始化顺序

对于静态变量、静态初始化块、变量、初始化块、构造器，它们的初始化顺序依次是（静态变量、静态初始化块）>（变量、初始化块）>构造器。

#### 继承的情况

```java
class Parent {
        /* 静态变量 */
    public static String p_StaticField = "父类--静态变量";
         /* 变量 */
    public String    p_Field = "父类--变量";
    protected int    i    = 9;
    protected int    j    = 0;
        /* 静态初始化块 */
    static {
        System.out.println( p_StaticField );
        System.out.println( "父类--静态初始化块" );
    }
        /* 初始化块 */
    {
        System.out.println( p_Field );
        System.out.println( "父类--初始化块" );
    }
        /* 构造器 */
    public Parent()
    {
        System.out.println( "父类--构造器" );
        System.out.println( "i=" + i + ", j=" + j );
        j = 20;
    }
}

public class SubClass extends Parent {
         /* 静态变量 */
    public static String s_StaticField = "子类--静态变量";
         /* 变量 */
    public String s_Field = "子类--变量";
        /* 静态初始化块 */
    static {
        System.out.println( s_StaticField );
        System.out.println( "子类--静态初始化块" );
    }
       /* 初始化块 */
    {
        System.out.println( s_Field );
        System.out.println( "子类--初始化块" );
    }
       /* 构造器 */
    public SubClass()
    {
        System.out.println( "子类--构造器" );
        System.out.println( "i=" + i + ",j=" + j );
    }


        /* 程序入口 */
    public static void main( String[] args )
    {
        System.out.println( "子类main方法" );
        new SubClass();
    }
}
```

```txt
父类--静态变量
父类--静态初始化块
子类--静态变量
子类--静态初始化块
子类main方法
父类--变量
父类--初始化块
父类--构造器
i=9, j=0
子类--变量
子类--初始化块
子类--构造器
i=9,j=20
```