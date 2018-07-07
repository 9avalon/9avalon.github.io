---
title : Redis
date : 2017-9-14 19:41
collection : NoSQL
---

# 查找大key
redis-cli --bigkeys 

```shell
./redis-cli -p 9803 --bigkeys
# Scanning the entire keyspace to find biggest keys as well as
# average sizes per key type. You can use -i 0.1 to sleep 0.1 sec
# per 100 SCAN commands (not usually needed).
[00.00%] Biggest string found so far 'MQS:700000-restful_srv_log-600000-run' with 9 bytes
[00.00%] Biggest list found so far 'mq:msg_ack_queue-600000-uat' with 27371754 items
-------- summary -------
Sampled 71 keys in the keyspace!
Total key length in bytes is 2747 (avg len 38.69)
Biggest string found 'MQS:700000-restful_srv_log-600000-run' has 9 bytes
Biggest list found 'mq:msg_ack_queue-600000-uat' has 27371754 items
53 strings with 239 bytes (74.65% of keys, avg size 4.51)
18 lists with 27376047 items (25.35% of keys, avg size 1520891.50)
0 sets with 0 members (00.00% of keys, avg size 0.00)
0 hashs with 0 fields (00.00% of keys, avg size 0.00)
0 zsets with 0 members (00.00% of keys, avg size 0.00)
```

