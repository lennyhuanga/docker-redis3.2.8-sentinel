#!/bin/bash
#docker run -itd -p 6379:6379 --name redisnodex huanglin/rediscluster:3.2.8 redis-server /etc/redis/6379.conf  
# the default node number is 6
N=${1:-6}


# start redis node container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f redis-node$i &> /dev/null
	echo "start redis-node$i container..."
	port=$(( $i + 6379 ))
	sudo docker run -itd \
	               # --net=redis \
				    -p $port:6379 \
	                --name redis-node$i \
	                --hostname redis-node$i \
	                huanglin/rediscluster:3.2.8 redis-server /etc/redis/6379.conf  
	i=$(( $i + 1 ))
done 

# get into redis node container
#sudo docker exec -it redis-node6379 bash