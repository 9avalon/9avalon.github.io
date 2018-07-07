---
title : zookeeper
date : 2016-10-14 09:29
updated : 2017-09-16 11:19
---

[TOC]


# Zookeeper

## zookepper 功能与使用场景

### 配置管理

在我们的应用中除了代码外，还有一些就是各种配置。比如数据库连接等。

一般我们都是使用配置文件的方式，在代码中引入这些配置文件。但是当我们只有一种配置，只有一台服务器，并且不经常修改的时候，使用配置文件是一个很好的做法，但是如果我们配置非常多，有很多服务器都需要这个配置，而且还可能是动态的话使用配置文件就不是个好主意了。

这个时候往往需要寻找一种集中管理配置的方法，我们在这个集中的地方修改了配置，所有对这个配置感兴趣的都可以获得变更。比如我们可以把配置放在数据库里，然后所有需要配置的服务都去这个数据库读取配置。

但是，因为很多服务的正常运行都非常依赖这个配置，所以需要这个集中提供配置服务的服务具备很高的可靠性。一般我们可以用一个集群来提供这个配置服务，但是用集群提升可靠性，那如何保证配置在集群中的一致性呢？ 

这个时候就需要使用一种实现了一致性协议的服务了。Zookeeper就是这种服务，它使用Zab这种一致性协议来提供一致性。现在有很多开源项目使用Zookeeper来维护配置，比如在HBase中，客户端就是连接一个Zookeeper，获得必要的HBase集群的配置信息，然后才可以进一步操作。还有在开源的消息队列Kafka中，也使用Zookeeper来维护broker的信息。在Alibaba开源的SOA框架Dubbo中也广泛的使用Zookeeper管理一些配置来实现服务治理。
>

### 统一命名服务

有一组服务器向客户端提供某种服务（例如：我前面做的分布式网站的服务端，就是由四台服务器组成的集群，向前端集群提供服务），我们希望客户端每次请求服务端都可以找到服务端集群中某一台服务器，这样服务端就可以向客户端提供客户端所需的服务。

对于这种场景，我们的程序中一定有一份这组服务器的列表，每次客户端请求时候，都是从这份列表里读取这份服务器列表。

那么这分列表显然不能存储在一台单节点的服务器上，否则这个节点挂掉了，整个集群都会发生故障，我们希望这份列表时高可用的。

高可用的解决方案是：这份列表是分布式存储的，它是由存储这份列表的服务器共同管理的，如果存储列表里的某台服务器坏掉了，其他服务器马上可以替代坏掉的服务器，并且可以把坏掉的服务器从列表里删除掉，让故障服务器退出整个集群的运行，而这一切的操作又不会由故障的服务器来操作，而是集群里正常的服务器来完成。

这是一种主动的分布式数据结构，能够在外部情况发生变化时候主动修改数据项状态的数据机构。Zookeeper框架提供了这种服务。这种服务名字就是：统一命名服务，它和javaEE里的JNDI服务很像。

## 基础使用&命令行

### 启动zk

```shell
zkService.sh start
```

### 进入zk控制台

```
zkCli.sh -server <host>:<port>   // eg. zkCli.sh -server 127.0.0.1:2181
```

### 查看zk包含的内容

```
ls /
```

### 查看zk 组内成员

```
ls /<node>
```

### 保存节点数据

```
set <path> <data>
```

### 获取节点数据

```
get <path>
```

## 使用Java连接Zookeeper

总结下来就像是一个树状的文件系统。

### 创建组

```java
/**
 * 创建组的类
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2017/1/11
 */
public class CreateGroup implements Watcher{
    private static final int SESSION_TIMEOUT = 5000;
    private ZooKeeper zk;
    private CountDownLatch connectedSignal = new CountDownLatch(1);

    public void connection(String hosts) throws IOException, InterruptedException {
        zk = new ZooKeeper(hosts, SESSION_TIMEOUT, this);
        connectedSignal.await();
    }

    @Override
    public void process(WatchedEvent watchedEvent) {
        if (watchedEvent.getState() == Event.KeeperState.SyncConnected) {
            connectedSignal.countDown();
        }
    }

    public void create(String groupName) throws KeeperException, InterruptedException {
        String path = "/" + groupName;
        String createdPath = zk.create(path, null, ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        System.out.println("Created " + createdPath);
    }

    public void close() throws InterruptedException {
        zk.close();
    }

    public static void main(String[] args) throws IOException, InterruptedException, KeeperException {
        CreateGroup createGroup = new CreateGroup();
        createGroup.connection("127.0.0.1");
        createGroup.create("zoo");
        createGroup.close();
    }
}
```

### Zk基础连接类

```java
/**
 * Zookeeper连接基础继承类
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2017/1/12
 */
public class ConnectionWatcher implements Watcher{

    private static final int SESSION_TIMEOUT = 5000;
    protected ZooKeeper zk;
    private CountDownLatch connectedSignal = new CountDownLatch(1);

    public void connect(String hosts) throws IOException, InterruptedException {
        zk = new ZooKeeper(hosts, SESSION_TIMEOUT, this);
        connectedSignal.await();
    }

    @Override
    public void process(WatchedEvent event) {
        if (event.getState() == Event.KeeperState.SyncConnected) {
            connectedSignal.countDown();
        }
    }

    public void close() throws InterruptedException {
        zk.close();
    }
}
```

### 加入组

```java
/**
 * 加入组
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2017/1/12
 */
public class JoinGroup extends ConnectionWatcher{

    public void join(String groupName, String memberName) throws KeeperException, InterruptedException {
        String path = "/" + groupName + "/" + memberName;
        String createdPath = zk.create(path, null, ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        System.out.println("Created " + createdPath);
    }

    public static void main(String[] args) throws IOException, InterruptedException, KeeperException {
        JoinGroup joinGroup = new JoinGroup();
        joinGroup.connect("127.0.0.1");
        joinGroup.join("zoo", "mingjian");
        Thread.sleep(Long.MAX_VALUE);
    }
}
```

### 列出组中成员

```java
/**
 * 列出组中成员
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2017/1/12
 */
public class ListGroup extends ConnectionWatcher{

    public void list(String groupName) throws KeeperException, InterruptedException {
        String path = "/" + groupName;

        try {
            List<String> children = zk.getChildren(path, false);
            if (children.isEmpty()) {
                System.out.println("no members in group: " + groupName);
                System.exit(1);
            }

            for (String child : children) {
                System.out.println(child);
            }
        } catch (KeeperException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException, KeeperException {
        ListGroup listGroup = new ListGroup();
        listGroup.connect("127.0.0.1");
        listGroup.list("zoo");
        listGroup.close();
    }
}
```

### 获取、保存数据

```java
/**
 * 获取组数据
 *
 * @version 1.0
 * @author: 侯铭健
 * @email mingjian_hou@kingdee.com
 * @time 2017/1/13
 */
public class DataOperator extends ConnectionWatcher{

    public void setData(String path, String data) throws KeeperException, InterruptedException {
        Stat st = zk.setData(path, data.getBytes(), -1);
    }
    
    public String getData(String path) throws KeeperException, InterruptedException, UnsupportedEncodingException {
        byte[] bytes = zk.getData(path, true, null);
        return new String(bytes, "UTF-8");
    }

    public static void main(String[] args) throws IOException, InterruptedException, KeeperException {
        DataOperator getGroupData = new DataOperator();
        getGroupData.connect("127.0.0.1");
//        getGroupData.setData("/zoo", "test");
        System.out.println(getGroupData.getData("/zoo"));
    }
}
```

