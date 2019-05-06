---
title: SSL添加CER证书
date: 2016-8-17 21:44:09
collection: JavaSE
---

## 错误提示

```log
Exception:sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderExc
eption: unable to find valid certification path to requested target
```

## 添加证书步骤

```sh
# 进入security目录
usr/java/jdk1.8.0_111/jre/lib/security

# 导入证书
keytool -import -alias server_tech -file /tmp/server_tech.cer -keystore cacerts -trustcacerts

# 不需要重启，马上就可以生效
```

## 关于证书复制

如果遇到jdk升级，或者服务证书迁移，可以直接复制拷贝证书文件。