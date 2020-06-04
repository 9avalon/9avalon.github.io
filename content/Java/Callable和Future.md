---
title: Callable和Future
date: 2020-06-04 15:47:59
collection: 并发
---

## 用途

让多线程执行完毕后，返回线程执行的值。适用于并行处理，子线程结果汇总。

## 简单demo

```java
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        Callable myCallable1 = () -> {
            Thread.sleep(5000);
            return i.incrementAndGet();
        };

        Callable myCallable2 = () -> {
            Thread.sleep(10000);
            return i.incrementAndGet();
        };

        List<Future<Integer>> list = new ArrayList<>();

        ThreadPoolTaskExecutor threadPoolExecutor = new ThreadPoolTaskExecutor();
        threadPoolExecutor.initialize();
        threadPoolExecutor.setCorePoolSize(5);
        threadPoolExecutor.setMaxPoolSize(10);
        threadPoolExecutor.setKeepAliveSeconds(10);

        Future<Integer> future = threadPoolExecutor.submit(myCallable1);
        Future<Integer> future1 = threadPoolExecutor.submit(myCallable2);

        list.add(future);
        list.add(future1);

        for (Future<Integer> l : list) {
            System.out.println(l.get());
        }

        System.out.println("123123123123");
    }
```

