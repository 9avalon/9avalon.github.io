---
title: HTTPS
date: 2020-03-27 11:24:39
---

参考资料：

https://www.cnblogs.com/franson-2016/p/5530671.html

http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html

## HTTP和HTTPS的区别

http协议，数据在网络传输是明文传输。

https协议，数据在网络传输是密文传输。

https由ssl和http协议进行网络上的加密传输

## SSL

1. 客户端向服务端发起请求，服务端返回证书，里面包含服务端的公钥
2. 客户端验证证书的有效性，验证通过后，随机生成字符串用做验证加密，对称加密。
