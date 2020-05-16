---
title : Easyexcel
date : 2019-06-17 13:02
collection: Java框架
---

## EasyExcel

### 引入依赖

```xml
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>easyexcel</artifactId>
    <version>1.0.0-RELEASE</version>
</dependency>
```

### 写表格

#### 表实体对象

```java
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Model extends BaseRowModel {

    @ExcelProperty(value = "ID" ,index = 0)
    private String id;

    @ExcelProperty(value = "ACCOUNT_TYPE" ,index = 1)
    private Integer accountType;
}
```

#### 生成代码

```java
private String report(ExamleClass examleClass) throws FileNotFoundException {
    String filePath = getFileFullPath();
    OutputStream out = new FileOutputStream(filePath);
    try {
        ExcelWriter writer = new ExcelWriter(out, ExcelTypeEnum.XLSX,false);
        Sheet sheet1 = new Sheet(1, 0, Model.class);
        sheet1.setSheetName("sheet1");
        writer.write(examleClass.getList1(), sheet1);

        Sheet sheet2 = new Sheet(2, 0, Model.class);
        sheet2.setSheetName("sheet2");
        writer.write(examleClass.getList2(), sheet2);

        writer.finish();
    } catch (Exception e) {
        // log....
    } finally {
        try {
            out.close();
        } catch (IOException e) {
            // log......
        }
    }
    return filePath;
}
```

## 读excel

```xml
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>easyexcel</artifactId>
            <version>2.2.3</version>
        </dependency>
```

Main入口

```java
    /**
     * 指定列的下标或者列名
     *
     * <p>
     * 1. 创建excel对应的实体对象,并使用{@link ExcelProperty}注解. 参照{@link IndexOrNameData}
     * <p>
     * 2. 由于默认一行行的读取excel，所以需要创建excel一行一行的回调监听器，参照{@link IndexOrNameDataListener}
     * <p>
     * 3. 直接读即可
     */
    public static void indexOrNameRead() {
        String fileName = "/Users/sakiri/Downloads/mool.xls";
        // 这里默认读取第一个sheet
        EasyExcel.read(fileName, IndexOrNameData.class, new IndexOrNameDataListener()).sheet().doRead();
    }
```

Listener类

```java
@Slf4j
public class IndexOrNameDataListener extends AnalysisEventListener<IndexOrNameData> {
    List<IndexOrNameData> list = new ArrayList<IndexOrNameData>();

    @Override
    public void invoke(IndexOrNameData data, AnalysisContext context) {
        list.add(data);
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        log.info("所有数据解析完成！list={}", list.size());
    }
}
```

```实体类
/**
 * 基础数据类
 *
 * @author Jiaju Zhuang
 **/
@Data
public class IndexOrNameData {
    /**
     操作人名称
     */
    @ExcelProperty("userName")
    private String userName ;
}
```
