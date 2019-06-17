---
title : Easyexecl
date : 2019-06-17 13:02
collection: Java框架
---

## Ali-easyexecl

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
public class CheckBalanceReportModel extends BaseRowModel {

    @ExcelProperty(value = "ID" ,index = 0)
    private String id;

    @ExcelProperty(value = "ACCOUNT_TYPE" ,index = 1)
    private Integer accountType;
}
```

#### 生成代码

```java
private String report(CheckBalanceReportEntity checkBalanceReportEntity) throws FileNotFoundException {
    String filePath = getFileFullPath();
    OutputStream out = new FileOutputStream(filePath);
    try {
        ExcelWriter writer = new ExcelWriter(out, ExcelTypeEnum.XLSX,false);
        Sheet sheet1 = new Sheet(1, 0, CheckBalanceReportModel.class);
        sheet1.setSheetName("sheet1");
        writer.write(checkBalanceReportEntity.getAccountNotExistList(), sheet1);

        Sheet sheet2 = new Sheet(2, 0, CheckBalanceReportModel.class);
        sheet2.setSheetName("sheet2");
        writer.write(checkBalanceReportEntity.getBalanceNotFixListList(), sheet2);

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
