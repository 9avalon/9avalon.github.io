---
title: JSP
date: 2016-6-23 17:00:21
collection: Java框架
---

[TOC]

#### 给页面反馈错误信息

现在已经不推荐用这种写法了，因为一般来说，所有的错误显示都不应该由后端来提供。而且现在提倡使用json来显示错误信息。
```jsp
<c:if test="${not empty err}">
	<script type="text/javascript">
		alert('${err}');
	</script>
</c:if>
```

#### 获取相对于项目的路径
```jsp
<!-- 相对于工程路径的写法 -->
<c:url value='/student.do?flag=register'/>
```


#### 引入c标签库
```jsp
<!-- c标签库-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```

#### 选择
```jsp
<!-- choose when otherwise 的使用：用于多分支条件判断 -->
<c:choose>
	<c:when test="${c.name=='lalala1' or c.name=='lalala'}"> <!-- 相当于if -->
	ok!
	</c:when>
	<c:when test="${c.name=='lalala2' or c.name=='lalala3'}"> <!-- 相当于else if -->
	ok2!
	</c:when>
	<c:otherwise><!-- 相当于else -->
		err!
	</c:otherwise>
</c:choose>
```

#### 判断
```jsp
<!-- 数值判断(如果发现是和数值进行判断，系统会尝试着把对象域的值转换成数值与之比较) -->
<c:if test="${a==111 and a==222}">ok1</c:if>
<!-- 字符串判断 -->
<!--  
<c:if test="${b=='h'}">ok2</c:if>
-->
<c:if test="${c.name=='lalala'}">ok3</c:if>
```

#### 循环
varStatus 表示循环中变量状态
varStatus.index 循环中的下标，从0开始 
```jsp
<c:forEach var="i" begin="1" end="10" step="1">
	<c:out value="${i}">
</c:forEach>
```

#### 时间处理
引入
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

格式化时间
    String year = new SimpleDateFormat("yyyy").format(new Date());
    Date awardTime = new SimpleDateFormat("yyyy-MM-dd").parse(activityForm.getAwardDate());

在jsp页面中格式化时间

	<fmt:formatDate value="${dorm.checktime}" pattern="yyyy年MM月dd日  HH:mm:ss E"/>
