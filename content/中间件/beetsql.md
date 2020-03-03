---
title: beetsql
date: 2020-03-03 11:45:15
collection: 中间件
---

## 重写生成sql文件

```md
 updateByCondition
 ===
         ${SS}trim(){
                 <%
                 for(col in cols){
                  var colName=tableAlias+col;
                  var attr = @nc.getPropertyName(col);
                 %>
                         ${SS}if(${attr} != null){${SE}
                          ${colName}=${PS+attr+PE},
                         ${SS}}${SE}
                 <%}%>
         ${SS}}${SE}
```
