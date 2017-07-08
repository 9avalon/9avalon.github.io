---
title: 多线程
date: 2016-6-23 16:56:45
collection: JavaSE
---

[TOC]



#### 什么是线程

* 线程是程序执行过程中，能够执行程序代码的一个执行单元。每个进程都有自己独立的栈空间
* 其运行状态有：运行，就绪，挂起，结束。

#### 使用进程的好处
* 有效利用cpu资源
* 某些耗时操作可以交给线程去做，节省等待时间。
* 与进程相比，线程的开销更小。

#### 同步
* Java提供了synchronized关键字来实现同步，但是它是以很大的系统开销作为代价的，并且还可能会造成死锁，所以它并非用得越多越好。

#### Java怎么开启多线程
* 写一个类继承Thread，然后重写其run方法，最后new出来调用start方法。
* 实现Runnable接口，重写其run方法，然后在新建Thread t = new Thread（Runnable的实现类）

#### 可以直接通过调用run方法来实现多线程吗？
* 不可以。通常来说，系统是通过调用线程类的start启动一个线程的，此时线程就会处于就绪状态，然后JVM再调用run方法来使线程执行，但如果我们直接使用run方法，那只是相当于在主线程直接使用了run这个普通函数而已。

#### Thread.join()方法的作用是什么
* 使用了线程的join方法之后，主线程会等待子线程执行完毕之后才会结束。
* 使用情况：如果子线程需要用到大量的计算，主线程往往比子线程之前结束，但如果主线程处理完其他事务之后需要用到子线程的结果，那就可以用join等子线程计算完再使主线程结束。
```java
		Thread thread = new Thread(new Runnable() {
			
			@Override
			public void run() {
				try {
					Thread.sleep(5000);
					System.out.println("子线程执行完毕");
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		});
		thread.start();
//		thread.join();
		System.out.println("程序执行完毕");
		
	}
```
