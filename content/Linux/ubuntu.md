---
title: Ubuntu
date: 2016-6-24 18:06:23
collection: 运维
---

[TOC]

## 安装java

首先到官网下载jdk，注意x86和x64的版本下载

然后创建一个目录/usr/lib/jvm以便于把下载解压后的包放到这个目录
    sudo mkdir /usr/lib/jvm

解压并把解压后的jdk1.8.0_25文件夹放到/usr/lib/jvm目录中。注意：我现在下载的安装包在Desktop目录下所以直接Desktop目录下在操作，如果你所下载的安装包不在Desktop目录下，请先cd进入相应目录，再继续操作。
    sudo tar zxvf jdk-...... -C /usr/lib/jvm

进入到/usr/lib/jvm目录下
    cd /usr/lib/jvm

把解压后的jdk1.8.0_25文件夹重命名为java，以便于书写
    sudo mv jdk..... java

先进入vi编辑器（第一幅图），然后输入以下内容（第二幅图）。

    sudo vim ~/.bashrc

    export JAVA_HOME=/usr/lib/jvm/java
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH

输入如下代码
    source ~/.bashrc

测试，出现如下结果则安装好，你就可以尽情的编写Java程序了。
    java -version

## 安装mysql

直接命令行下载

    sudo apt-get install mysql-server
    apt-get isntall mysql-client
    sudo apt-get install libmysqlclient-dev

检查有无安装成功

sudo netstat -tap | grep mysql

### 修改中文编码

进入 /etc/mysql/my.cnf,打开mysql配置文件：

    vim/etc/mysql/my.cnf

在[client]下追加：

    default-character-set=utf8

在[mysqld]下追加：

    character-set-server=utf8

在[mysql]下追加：

    default-character-set=utf8

保存并退出,重启服务

    sudo service mysql restart

进入mysql控制台查看编码

    mysql>show variables like 'character%'

看到没有latian1则大功告成

## 添加远程账号

第一步：

    vim /etc/MySQL/my.cnf找到bind-address = 127.0.0.1

注释掉这行

    #bind-address = 127.0.0.1

或者改为，这样修改的意思是允许任意的ip访问，或者自己指定一个ip地址

    bind-address = 0.0.0.0

重启 mysql

    sudo /etc/init.d/mysql restart

第二步：

授权用户能进行远程连接

    grant all privileges on [database].* to [用户名]@"%" identified by "[password]" with grant option;

刷新

    flush privileges;

## 修改登陆后的默认位置

编辑配置文件

```sh
vi /etc/passwd
```

找到root所在行

```sh
root:x:0:0:root:/root:/bin/bash
```

修改默认目录

```sh
root:x:0:0:root:<path>:/bin/bash
```

保存退出

## 安装tomcat

从官网处下载tomcat的包，然后放到linux下解压