---
title: Linux命令速查
date: 2016-6-24 18:04
updated: 2018-11-28 00:47:06
collection: 运维
---

[TOC]

一些基本的命令容易忘掉，所以写下来当备忘录。

# Linux命令速查

## 解压

```sh
tar xvf wordpress.tar
```

## 复制

```sh
cp -R file1path file2path
```

## 查找文件

### find

```sh
# 精准搜索文件名
find <path> -name <file_name>

# 模糊搜索
find <path> -name '*<file_name>*'

# 查找txt结尾的文件，所有文件
find . -name "*.txt"

# 查找大于100m的大文件
find . -size +100M -exec ls -lhG {} \;

# 查找上下5行的内容
grep -C 5 foo file 显示file文件里匹配foo字串那行以及上下5行

# 查看文件5-10行内容
sed -n '5,10p' filename

# grep和tail命令组合
grep '' <file> | tail -10f

## grep

搜索多个文件内容


```

### grep

```sh
grep '<content>' <file_name or pattern>

ps:如果提示 binary file match 则加入参数 -a

# 递归查找 -r 递归 -n 行号
grep '要查找的内容' home/sync -r -n

```

## 文件上传/下载

```sh
# 下载文件到服务器
sudo wget <url>  
sudo wget <url> -O <file_name> //指定文件下载名

# 从服务器下载文件到本机
sz <filename> # 需要安装lrzsz

# 上传文件到服务器
rz
```

## 查看文件大小

```sh
du <file_name>
```

## 重命名文件

```sh
mv old_file_name new_file_name
```

## 权限

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

## 查看端口占用

例如，我要查看8080端口的占用

```sh
netstat -ap | grep 8080

lsof -i:<port>
```

## 查询进程

```sh
ps -aux | grep <name>
```

## 杀死进程

```sh
kill -9 pid
```

## 软连接

```sh
ln -s <true_file_path> <link>
目标文件被破坏，软连接还是会存在
```

## 查找大文件

```sh
find . -type f -size +800M -exec ls -lh {} \;
```

## 清空某个文件

```sh
cp /dev/null nohup.out
```

## Tomcat7

### 查看tomcat运行时日志

先进入logs目录

```sh
tail -f catalina.out  #ctrl + c退出
也可以查看catalina.out.201x.xx.xx #当天的日志
```

如果要将log进行筛选

```sh
tail -f catalina.out | grep 'something'
```

### 查看内存占用

```sh
free -m  # 看buffer的那一栏，第一列是使用的内存，第二列是还剩下多少内存
ps aux --sort -rss  # 查看内存占用大小，rss列为实际列
```

## SSH

```sh
ssh <ip> <port>
```

### SCP跨主机传输文件

```sh
scp -r <local_folder> <username>@<ip>:<remote_folder>
```

从远程复制到本地的scp命令与上面的命令一样，只要将从本地复制到远程的命令后面2个参数互换顺序就行了。

## 文件搜索

查找以trade_20180806开头的文件中，包含10002018080615310877684437的文件以及内容
grep '10002018080615310877684437' trade_20180806*

## less命令

对于大文件的处理，要用less，vim会读取文件所有，很可能导致系统死掉。

### 命令行操作

ctrl + F - 向前移动一屏
ctrl + B - 向后移动一屏

j - 向前移动一行
k - 向后移动一行

G - 移动到最后一行
g - 移动到第一行

-n 显示行号

## 终端快捷键相关

```shell
ctrl + l  清空当前屏幕
ctrl + u  清空光标之前的字符

ctr+a：移动光标到命令行开始处（紧接命令提示符号）  
ctr+e：移动光标到命令行行尾  

ctr+k：删除光标到命令行行尾  
ctr+u：删除光标到命令行开始处  

ctr+h: 往后删除一字符
ctr+d: 往前删除一字符  

ctr+b: 光标往前
ctr+f: 往后

ctr+u: 删除到最前
ctr+K: 删除到最后  

ctr+a: 光标到最前
ctr+e: 光标到最后  

ctr+p: 往上一条历史命令
ctr+n: 往下一条命令

```

## 文件比对

```shell
diff -abyW <file1> <file2>
```

## 文件排序

```sh
# 对file排序，并输出到新的文件中
sort <file> > <new_file>
```

## .gz文件不解压处理

```shell
# 不解压查看
zcat <file> | less

## grep搜索
zgrep "/api" access_log.gz
```
