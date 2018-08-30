第一步：安装git
第二步：git clone https://github.com/lennyhuanga/docker-redis3.2.8-sentinel

第三步：创建redis master 镜像
##需要注意吧5000.conf 、Dockerfile等配置文件中master地址改成真实ip地址
cd master
mkdir config
cd ..
cp  config/*  master/config/
chmod 777 build-image.sh
./build-image.sh

第四步：创建 redis slave 镜像
##需要注意吧5000.conf 、Dockerfile等配置文件中master、slave地址改成真实ip地址
cd slave
mkdir config
cd ..
cp  config/*  slave/config/
chmod 777 build-image.sh
./build-image.sh

第五步：创建容器
chmod 777 start-container.sh
./start-container.sh

第六步：开启sentinel
分别进入master slave
ps -ef|grep redis
chmod 777 start-reids.sh
chmod 777 start-sentinel.sh
./ start-sentinel.sh
redis-cli -a xxxx 
info

-----------------------------------------------------------------------------------------
https://www.cnblogs.com/cxbhakim/p/9151720.html
安装redis cluster
第一步：安装git
第二步：git clone https://github.com/lennyhuanga/learn
第三步：创建redis node 镜像
##需要注意吧5000.conf 、Dockerfile等配置文件中master地址改成真实ip地址
cd rediscluster
mkdir config
cd ..
cp  config/*  master/config/
chmod 777 build-image.sh
./build-image.sh
第四步：创建容器
chmod 777 start-container.sh
./start-container.sh

