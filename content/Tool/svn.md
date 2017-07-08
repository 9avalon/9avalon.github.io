---
title: svn
date: 2016-6-23 18:33:22
collection: 项目代码控制
---

[TOC]

#### 什么是svn
svn和git是目前使用最广泛的版本管理工具，知道github的朋友肯定也知道git并且使用过git，但其实svn也是一款很优秀的版本管理工具，与git的分布式不同的是，svn是集中式管理，拥有更细致的按照目录级别的权限控制。

#### 在服务器中新建仓库
下面的操作步骤我都是默认服务器环境中已经搭建好svn了，有时候新建svn仓库的命令我会忘记掉，所以就只记录下新建svn仓库的步骤了。

首先创建仓库文件夹，然后执行下面命令

    svnadmin create /root/svn/projectname

进入svn仓库项目的目录

    /root/svn/projectname/conf   

这里要修改三个配置文件分别是passwd， svnserve.conf ，和authz。  

authz是管理用户权限的，其中rw表示读和写，account表示用户名。

    [/]
    account=rw


passwd 当然是管理每个用户的密码啦

    account=password

svnserve.conf管理svn的一些基本配置，我们把下面的三行去掉注释。

    anon-access = none
    auth-access = write 
    password-db = passwd

修改完后保存就可以了。

#### 设置同步更新
同步更新的意思是，在服务器也把代码检出来，然后设置同步更新后，在本地提交更新后，服务器上检出的代码也会随着一起更新掉。我使用这个来部署tomcat的项目。

先在服务器检出svn仓库，注意这里的仓库地址是远程地址
​    
    svn co 仓库地址  

在linux仓库地址的hook文件夹下新建post-commit，这里的仓库地址是linux上的地址。
``` bash
#!/bin/sh
export LANG=zh_CN.UTF-8
cd 检出的仓库地址
svn cleanup
svn update 检出的仓库地址 --username 账号 --password 密码 --no-auth-cache
```

最后提升这个文件的权限

    chmod 777 /usr/svn/baoming/hooks/post-commit

ok
​       