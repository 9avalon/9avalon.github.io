---
title : Docker
draft : true
---

[TOC]

## Centos安装docker

centos安装docker版本有点麻烦，因为现在主流的centos版本都是6.3-6.5，这些版本的linux内核有点旧，docker支持不了，需要升级内核

## 查看docker版本

```sh
docker version
```

## 基本命令

```sh
# 搜索镜像
docker search <resource>
# 下载镜像
docker pull <resource>
# 查看镜像
docker images
# 删除镜像
docker rmi <IMAGE> | <IMAGE_ID>


# 启动容器
docker run -it <container>
# 查看容器
docker ps
# 查看所有容器
docker ps -l
# 守护状态运行容器
docker run -d <container>
# 进入容器
docker exec -ti <id> {/bin/bash指定程序}
# 查看容器log
docker logs <id>
# 终止容器
docker stop <id>
# 保存容器做的修改
docker commit <id> <name>
# 删除容器
docker rm <id>
# 清理所有已经停止的容器
docker rm $(docker ps -a -q)
```

## 其他

1、更换阿里源

```sh
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak #备份
sudo vim /etc/apt/sources.list #修改
sudo apt-get update #更新列表
```

```sh
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
```

