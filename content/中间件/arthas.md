---
title : Arthas
date : 2019-03-11 19:41:11
---

## 需要重启的热部署(不依赖arthas)

第一步先本地把改好的代码编译为class。

第二步在线上jar包的旁边新建与jar包同级的目录

```shell
mkdir -p BOOT-INF/classes/com/xxx/xxx
```

第三步将修改后的class包放进上面创建的目录里面

第四步执行命令，替换jar包里面的class文件

```shell
jar -uvf xxx-1.0.1-SNAPSHOT.jar com/xxx/xxx/xxx/xxx.class
```

替换成功后，重启服务，确认。

## 不需要升级的热部署(依赖arthas)

可以利用arthas的热部署功能。

[Arthas实践--jad/mc/redefine线上热更新一条龙](https://github.com/alibaba/arthas/issues/537)

## trace

```sh
# 监控该方法堆栈
trace com.xxx.xxx.xxx.xxxController method

# 后台执行任务，统计耗时超过5s的堆栈，并且打印到`pwd` 目录下的test.out文件
trace com.xxx.xxx.xxx.xxxController method '#cost > 5000' >> test.out &
```

## watch

```sh
watch com.xxx.xxx.xxx.xxxController method "{params,returnObj}" -x 2
```

