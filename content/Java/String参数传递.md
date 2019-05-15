---
title: String参数传递
date: 2016-6-23 16:59:23
collection: JavaSE
---

之前一直很迷茫，到底Java中的参数是怎样传递的，有些人说分两种，一种是传值，一种是传引用。而另一种是说Java传的都是值。

我经过研究之后是比较赞同第二种说法的，Java传递的都是值，只不过如果是对象的话，传递的是对象的地址。
举个栗子：

```java
public static void main(){
    String str = "123";
    change(str);
    System.out.print(str);
}
public static void change(String str){
    str = null;
}
```

输出结果还是123，为什么会这样呢。首先change传递过去的是str的地址，就是说str=str地址，然后str=null,相当于原来的地址被覆盖了，所以str并没有变。那如果我是这样。

```java
public static void change(String str){
    str = “123123”;
}
```

输出其实还是不变的，因为String是不可变类，str的值是不可以改变的，str="123123"相当于重新new了一个“123123”的字符串然后再赋值给str
相当于str = new String("123123""); 所以原来的地址也会被覆盖掉，因此改变的就无效了。