---
title: WebFilter
date: 2019-05-09 12:15:22
collection: Java框架
---

1.引入依赖，这里因为框架内使用的是springboot，所以引入了这个

```xml
<dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

2.Application配置

```java
// 注入filter
@ServletComponentScan(basePackages = {"com.xxx.xxx"})
```

3.代码编写

```java
@WebFilter(filterName = "whiteListFilter", urlPatterns = "/health")
@Component
public class WhiteListFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // PASS
        //filterChain.doFilter(servletRequest, servletResponse);
        //return;

        // REJECT
        //servletResponse.getOutputStream().print(FilterHttpResp.rejectJSON());
        //return;
    }

    @Override
    public void destroy() {
    }
}
```