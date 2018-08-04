---
title: git
date: 2016-6-23 18:31:49
collection: 项目代码控制
---

[TOC]

# git命令

## 查看远程源

```sh
git remote -v  //查看
git remote rm <name> //移除
git remote add <name> <url> //添加
```

## 查看被修改过的文件列表

```sh
git status
```

## 添加当前目录文件 git add [目录]

```sh
git add .
```

## 撤销git add

```sh
git reset
```

## 提交

```sh
git commit -m 'your comment'
git commit -am 'your comment'   #add+commit
```

## 提交反悔

```sh
git reset --hard HASH #返回到某个节点，不保留修改。
git reset --soft HASH #返回到某个节点。保留修改
```

## 更新远程fork的项目

首先，将被fork项目的源添加进来。

```sh
git remote add [upstream] [giturl]
git fetch [upstream]
git pull [upstream] master
```

相当于把远程源拉回来。
在这其中，可能会有冲突，如果有冲突，则将冲突解决掉之后，git add 冲突文件并且commit->push到服务器上。

## git add恢复

有时候我们把文件提交上去了，但是突然发现add错了文件，那怎么办呢

我们可以恢复add之前的状态

```sh
git reset head
```

或者单独移除文件

```sh
git rm -cached <FILE>
```

## git commit 恢复

```shell
git reset --soft <commit_id>
```

## 解决冲突

当我们pull远程源merge然后发现有冲突的时候，git会提示我们某个文件需要解决冲突，一般来说，只要到本地种把冲突的文件修改，然后add commit掉，就可以了。

## 还原本地所有代码

本地所有修改，没有提交的，都返回到原来的状态

```sh
git checkout .
```

## 回退到某个commit版本

```sh
git reset --hard <commit_id>
```

## 查看某次git修改了哪些文件

```sh
git show <commit_id>
```

## 修改commit内容

```sh
git commit --amend
```

### git 分支

## 查看分支

```sh
git branch  -va //查看本地和远程的分支
git branch -a  //查看远程的分支  
```

## 切换分支

```sh
git checkout <branch_name> //切换分支
git checkout -b <branch_name> <origin>/<origin_branch_name>
eg: checkout -b devlop origin/devlop
```

## 删除分支

```sh
git branch -d <branch_name>
```

删除远程分支

```sh
git push origin :<branch_name>
```

## 重命名本地分支

```sh
git branch -m <old_name> <new_name>
```

## 合并分支代码

branch_name 为要合并的分支

```sh
git merge <branch_name>
```

## 将分支推送到远程服务器上

其中local_branch_name在本地中必须存在
第二个branch_name对应远程分支的名称。

```sh
git push origin <local_branch_name>:<branch_name>
```

## 暂存

```sh
git stash #把所有没有提交的修改暂存到stash里面。
git stash pop #回复暂存区的代码。
git stash list #查看所有的暂存

git stash save <comment> #有备注信息的暂存,强烈推荐这个命令，很多时候直接stash会忘掉
```

## git强行回退分支版本

```sh
git log 
git reset --hard <commit_id>
git commmit -am ''
git push -f origin <branch_name>

# 注意，一定不要使用git push -force 这个命令！！！ 即使要用也要带上相对应的分支
# git push origin <branch_name> -force 
```

## 删除远程分支

```sh
git push origin :branch-name
```

## git bash 脚本

在git的安装目录下新建文件，`git-xxx.sh` 然后编写该sh文件，示例如下：

```sh
!/bin/sh
git add .
git commit -m 'update'
git push
```

那么我们就可以在git仓库中使用该命令(git有添加到环境变量中)，就会自动执行git-xxx.sh中的内容

```sh
git xxx.sh
```

本wiki就是使用这个来做自动部署的

## 使用SSH来连接GitHub

因为之前写脚本的时候http方式连接在push的时候需要填写邮箱和密码，而ssh方式不用，所以才会接触到这块的东西。

这一段摘自 [github设置添加SSH](http://blog.csdn.net/binyao02123202/article/details/20130891)

> 很多朋友在用github管理项目的时候，都是直接使用https url克隆到本地，当然也有有些人使用 SSH url 克隆到本地。然而，为什么绝大多数人会使用https url克隆呢？
>
> 这是因为，使用https url克隆对初学者来说会比较方便，复制https url 然后到 [Git](http://lib.csdn.net/base/28) Bash 里面直接用clone命令克隆到本地就好了。而使用 SSH url 克隆却需要在克隆之前先配置和添加好 SSH key 。
>
> 因此，如果你想要使用 SSH url 克隆的话，你必须是这个项目的拥有者。否则你是无法添加 SSH key 的。

https 和 SSH 的区别：
>1、前者可以随意克隆github上的项目，而不管是谁的；而后者则是你必须是你要克隆的项目的拥有者或管理员，且需要先添加 SSH key ，否则无法克隆。
>2、https url 在push的时候是需要验证用户名和密码的；而 SSH 在push的时候，是不需要输入用户名的，如果配置SSH key的时候设置了密码，则需要输入密码的，否则直接是不需要输入密码的

## 多个ssh使用

[同一个电脑多个sshkey管理](http://yijiebuyi.com/blog/f18d38eb7cfee860c117d629fdb16faf.html)

## 全局设置用户名和邮箱

```sh
git config --global user.name "wirelessqa"  
git config --global user.email wirelessqa.me@gmail.com  
```

如果想单独某个项目设置，则去掉 --global 即可

## 查看全局设置

```sh
git config --list // 查看设置
```

## gitignore

隐藏idea文件

```sh
/.idea
```

隐藏特定iml后缀文件

```sh
*.iml
```

## git突然崩溃

[git崩溃]: http://blog.csdn.net/michaeljy1991/article/details/50499202