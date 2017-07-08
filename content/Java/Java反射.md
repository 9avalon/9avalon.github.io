---
title: 反射
date: 2016-6-23 16:57:32
collection: JavaSE
---

[TOC]

最近准备学习Spring的源码, 考虑到Spring中的ioc和aop模块会有比较多的反射代码，而且这方面内容之前只是初略了解过，所以专门地去看了下java反射的相关使用。

#### 什么是Java的反射机制
简而言之，Java反射机制可以让我们在程序运行时，检查类，接口，变量，以及方法、注解等。
有了反射我们就可以做很多事情，例如，动态生成类，动态生成实例等。

为了方便，我们首先定义了一个Human Pojo类，这个类用来做测试对象。
```java
public class Human {
	public String HUMAN_PACKAGE = "org.mingzzz.reflect.Human";
	
	private String name;
	private String sex;
	private String age;
	
	public void run() { System.out.println("Running"); };
	public void speak() { System.out.println("Speaking"); }
	//构造函数
	public Human() {}
	//带参构造函数
	public Human(String name){ this.name = name; }
	//各种get set方法
	...................
}
```
#### 获取方法，调用方法
通过反射，我们可以轻松地获取到类的所有方法，也包括其父类的方法。

``` java
	public static void getMethods(){
		try{		
			// 打印出指定类的所有public方法,包括父类
			Method[] methods = Human.class.getMethods();
			for (Method method: methods){
				System.out.println("method = " + method.getName());
			}
			
			// 获取指定名字的方法，并且执行之
			Method  method = Human.class.getMethod("setName", String.class);
			Human human = new Human();
			method.invoke(human, "kaka");
			System.out.println(human.getName());
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
```
输出结果
可以看到，除了一些我们自己定义的方法，连父类的Object的方法也被打印了出来
后面我们通过反射调用了Human的setName方法，改变了Human的Name值
![](http://7xt3lj.com2.z0.glb.clouddn.com/markdown%E5%8F%8D%E5%B0%841.png)

#### 获取注解
下面的几个都是大同小异的了，我就不详细展开写了，只贴了代码出来，只需要知道反射能这样获取内容就可以了。
```java
	public static void getAnno(){
		Annotation[] annotations = Human.class.getAnnotations();
		for (Annotation anno: annotations){
			System.out.println("anno = " + anno.annotationType());
		}
	}
```

#### 获取构造函数
```java
	public static void getConstructor(){
		try{
			// 获取构造函数
			Constructor constructor = Human.class.getConstructor(String.class);
			// 通过构造函数实例化对象
			Human human = (Human) constructor.newInstance("小猴");
			
			System.out.println(human.getName());
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
```

#### 获取变量
```java
public static void getFields(){
		try {
			//获取类中所有的public变量
			Field[] fields =  Human.class.getFields();
			for (Field field: fields){
				System.out.println("public == fieldName = " + field.getName() + " ====== fieldType = " + field.getType());
			}
			
			//获取类中的所有private变量
			Field[] privateFields = Human.class.getDeclaredFields();
			for (Field pfield: privateFields){
				System.out.println("private == fieldName = " + pfield.getName() + " ====== fieldType = " + pfield.getType());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
```

