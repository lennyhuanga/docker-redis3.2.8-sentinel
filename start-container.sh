#!/bin/bash
#docker run -itd -p 6379:6379 --name redismaster huanglin/redismaster:3.2.8 redis-server /etc/redis/6379.conf  
# the default node number is 3
N=${1:-3}


# start redis master container 
sudo docker rm -f redis-master &> /dev/null
echo "start redis-master container..."
sudo docker run -itd \
               # --net=redis \
                -p 6379:6379 \
                --name redis-master \
                --hostname redis-master \
                huanglin/redismaster:3.2.8 redis-server /etc/redis/6379.conf  


# start redis slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f redis-slave$i &> /dev/null
	echo "start redis-slave$i container..."
	port=$(( $i + 6379 ))
	sudo docker run -itd \
	               # --net=redis \
				    -p $port:6379 \
	                --name redis-slave$i \
	                --hostname redis-slave$i \
	                huanglin/redislave:3.2.8 redis-server /etc/redis/6379.conf  
	i=$(( $i + 1 ))
done 

# get into redis master container
sudo docker exec -it redis-master bash