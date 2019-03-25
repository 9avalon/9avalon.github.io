---
title : Nginx
date : 2019-01-21 00:29:19
---

# 命令速记

[Command Line](https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/)

```sh
# 启动nginx
brew services nginx start

# 检查配置路径以及语法
nginx -t

# 重新读取配置
nginx -s reload

# 指定配置文件路径
nginx -c /usr/local/etc/nginx/nginx.conf
```

# 参考链接

[nginx配置文件详解中文版](https://www.jianshu.com/p/a7c86efe1987)