---
title : Jaxb
date : 2017-8-28 20:14
updated : 2017-8-28 20:14
collection : JavaSE
---

# JAXB

## 什么是jaxb

Jaxb是JavaEE的规范.全称Java Architecture for XML Binding.

>JAXB 2.0是JDK 1.6的组成部分。JAXB 2.2.3是JDK 1.7的组成部分。在实际使用不需要引入新的jar. 该包包含在jdk的rt.jar中

通过它，我们可以以注解的方式，灵活地实现xml与entity之间的转换

## 常用注解

### @XmlRootElement

处于类级别的注解，用来标识根节点，常与@XmlAccessorType一起使用

```
@XmlRootElement(name = "condition")
@XmlAccessorType(XmlAccessType.FIELD)
```

### @XmlElement

用于标识根节点下的子节点

### @XmlAttribute

用于标识根节点的属性

### @XmlElementWrapper

相当于外节点又包了层

```java
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class Customer {
 
    @XmlElementWrapper(name="email-addresses")
    @XmlElement(name="email-address")
    private List<String> emailAddresses;
 
}
```

输出
```xml
<customer>
    <email-addresses>
        <email-address>janed@example.com</email-address>
        <email-address>jdoe@example.org</email-address>
    </email-addresses>
</customer>

```

## xml与entity互转

目前在用的工具类如下(从网上摘录的):

```java
    /**
     * JavaBean转换成xml
     * 默认编码UTF-8
     */
    public static String convertToXml(Object obj) {
        return convertToXml(obj, "UTF-8");
    }

    /**
     * JavaBean转换成xml
     */
    public static String convertToXml(Object obj, String encoding) {
        String result = null;
        try {
            JAXBContext context = JAXBContext.newInstance(obj.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, false);
            marshaller.setProperty(Marshaller.JAXB_ENCODING, encoding);

            StringWriter writer = new StringWriter();
            marshaller.marshal(obj, writer);
            result = writer.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * xml转换成JavaBean
     */
    @SuppressWarnings("unchecked")
    public static <T> T converyToJavaBean(String xml, Class<T> c) {
        T t = null;
        try {
            JAXBContext context = JAXBContext.newInstance(c);
            Unmarshaller unmarshaller = context.createUnmarshaller();
            t = (T) unmarshaller.unmarshal(new StringReader(xml));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return t;
    }
```