
之前几讲都是在铺垫各种redis replication的原理，和知识，主从，读写分离，画图

知道了这些东西，关键是怎么搭建呢？？？

一主一从，往主节点去写，在从节点去读，可以读到，主从架构就搭建成功了

1、启用复制，部署slave node

wget http://downloads.sourceforge.net/tcl/tcl8.6.1-src.tar.gz
tar -xzvf tcl8.6.1-src.tar.gz
cd  /usr/local/tcl8.6.1/unix/
./configure  
make && make install

使用redis-3.2.8.tar.gz（截止2017年4月的最新稳定版）
tar -zxvf redis-3.2.8.tar.gz
cd redis-3.2.8
make && make test && make install

（1）redis utils目录下，有个redis_init_script脚本
（2）将redis_init_script脚本拷贝到linux的/etc/init.d目录中，将redis_init_script重命名为redis_6379，6379是我们希望这个redis实例监听的端口号
（3）修改redis_6379脚本的第6行的REDISPORT，设置为相同的端口号（默认就是6379）
（4）创建两个目录：/etc/redis（存放redis的配置文件），/var/redis/6379（存放redis的持久化文件）
（5）修改redis配置文件（默认在根目录下，redis.conf），拷贝到/etc/redis目录中，修改名称为6379.conf

（6）修改redis.conf中的部分配置为生产环境

daemonize	yes							让redis以daemon进程运行
pidfile		/var/run/redis_6379.pid 	设置redis的pid文件位置
port		6379						设置redis的监听端口号
dir 		/var/redis/6379				设置持久化文件的存储位置

（7）让redis跟随系统启动自动启动

在redis_6379脚本中，最上面，加入两行注释

# chkconfig:   2345 90 10

# description:  Redis is a persistent key-value database

chkconfig redis_6379 on

在slave node上配置：slaveof 192.168.1.1 6379，即可

也可以使用slaveof命令

2、强制读写分离

基于主从复制架构，实现读写分离

redis slave node只读，默认开启，slave-read-only

开启了只读的redis slave node，会拒绝所有的写操作，这样可以强制搭建成读写分离的架构

3、集群安全认证

master上启用安全认证，requirepass
master连接口令，masterauth

4、读写分离架构的测试

先启动主节点，eshop-cache01上的redis实例
再启动从节点，eshop-cache02上的redis实例

刚才我调试了一下，redis slave node一直说没法连接到主节点的6379的端口

在搭建生产环境的集群的时候，不要忘记修改一个配置，bind

bind 127.0.0.1 -> 本地的开发调试的模式，就只能127.0.0.1本地才能访问到6379的端口

每个redis.conf中的bind 127.0.0.1 -> bind自己的ip地址
在每个节点上都: iptables -A INPUT -ptcp --dport  6379 -j ACCEPT

redis-cli -h ipaddr
info replication

在主上写，在从上读
