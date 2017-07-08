---
title: redis
date: 2016-8-28 22:51:01
draft: true
---



安装Redis服务器端

```sh
sudo apt-get install redis-server
```

检查Redis服务器系统进程

```sh
ps -aux|grep redis
```

通过启动命令检查Redis服务器状态

```sh
netstat -nlt|grep 6379
```

重启redis

```
sudo service redis-server restart
```



批量删除key

```
redis-cli keys “*” | xargs redis-cli del

redis-cli -p 6379 keys "ACCOUNT*"
redis-cli -h 127.0.0.1 -p 6379 keys *ACCOUNT* | xargs redis-cli -p 6379 del
redis-cli -p 9200 keys *ACCOUNT* | xargs redis-cli -p 9200 del
```





```
redis-cli -p 9200 keys *ACCOUNT_next_* | xargs redis-cli -p 9200 del
redis-cli -p 9200 keys *ACCOUNT_first_* | xargs redis-cli -p 9200 del
redis-cli -p 9200 keys *ACCOUNT_pay_channel* | xargs redis-cli -p 9200 del
```

