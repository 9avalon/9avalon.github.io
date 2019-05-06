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

简单来说，步骤


 [INFO ] 2019-03-15 03:09:06,592 -1800- [XNIO-2 task-64] [com.bluepay.voucher.controller.RestfulController] 请求入参=======>ReqQueryVoucher(customerId=CHGZZ9Q5T208, userId=null, paymentChannel=1,-2,0,5,6,7,11,12, cardType=3,4, status=0, producerId=3, limitStart=null, li
mit=null, rankByExpiredTime=asc, encrypt=a5f9ca9a25d7e719aad0549c12d934d1)
 [INFO ] 2019-03-15 03:09:06,602 -1800- [XNIO-2 task-64] [com.bluepay.voucher.data.service.bus.QueryService] 根据规则查询的结果为===>>voucherInfoList = []
 [INFO ] 2019-03-15 03:09:06,602 -1800- [XNIO-2 task-64] [com.bluepay.voucher.data.service.bus.QueryService] 开始解查询的得到的卡号=====>>
 [INFO ] 2019-03-15 03:09:06,602 -1800- [XNIO-2 task-64] [com.bluepay.voucher.controller.RestfulController] 请求出参=======>{"result":[],"status":200}