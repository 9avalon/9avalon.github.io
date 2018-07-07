---
title: 常用命令
date: 2016-6-24 18:04
updated: 2017-8-31 12:09
---

[TOC]

一些基本的命令容易忘掉，所以写下来当备忘录。

### 常用

#### 解压

```sh
tar xvf wordpress.tar       ####解压tar格式的文件####
```


#### 复制
```sh
cp -R file1path file2path
```

#### 查找文件
```sh
find / -name <file_name> 
```
#### 下载

```sh
sudo wget <url>  
sudo wget <url> -O <file_name> //指定文件下载名
```

#### 查看文件大小

```sh
du <file_name>
```

#### 权限

数字的代表含义：

r ------------4

w -----------2

x ------------1

无------------0

所以我平时常用的有主要有755（所有者所有权限，组读和执行，其他人读和执行），也可以对其他人限制得更厉害。

```sh
sudo chmod <auth_number>  // 修改权限
ls -l path/filename   // 查看权限
```

#### 查看端口占用

例如，我要查看8080端口的占用

```sh
netstat -ap | grep 8080
```

#### 重命名文件

```sh
sudo mv old_file_name new_file_name
```

#### 选择进程

```sh
ps -aux | grep <name>
```

#### 杀死进程

```sh
kill -9 pid
```

#### 下载文件

```sh
sz <filename> # 需要安装lrzsz
```

#### 清屏

```sh
clear	
```

#### 查看端口占用

```sh
netstat -tunlp
```

#### 查看目录文件详细

```sh
ls -lrsh  升序
ls -lsh   降序
```

#### 软连接

```sh
ln -s <true_file_path> <link>
目标文件被破坏，软连接还是会存在
```

#### 查找大文件

```sh
find . -type f -size +800M -exec ls -lh {} \;
```

#### 清空某个文件

```sh
cp /dev/null nohup.out
```



### Tomcat7

#### 查看tomcat运行时日志

先进入logs目录

```sh
tail -f catalina.out  #ctrl + c退出
也可以查看catalina.out.201x.xx.xx #当天的日志
```

如果要将log进行筛选

```
tail -f catalina.out | grep 'something'
```



### 查看内存占用

```sh
free -m  # 看buffer的那一栏，第一列是使用的内存，第二列是还剩下多少内存
ps aux --sort -rss  # 查看内存占用大小，rss列为实际列
```

### SSH

```sh
ssh <ip> <port>
```

### SCP跨主机传输文件

```sh
scp -r <local_folder> <username>@<ip>:<remote_folder>
```

从远程复制到本地的scp命令与上面的命令一样，只要将从本地复制到远程的命令后面2个参数互换顺序就行了。

