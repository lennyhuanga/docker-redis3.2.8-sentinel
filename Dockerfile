FROM ubuntu:14.04

MAINTAINER huanglin <524180539@qq.com>

WORKDIR /root


# install openssh-server, openjdk and wget gcc make (����װgcc��make perl��װ�������)
RUN apt-get update && apt-get install -y openssh-server openjdk-7-jdk wget gcc make

# install perl5.16.1���ɸ���������ú��ʵİ汾��
RUN wget  https://www.cpan.org/src/5.0/perl-5.28.0.tar.gz && \
	tar -xzf perl-5.28.0.tar.gz && \
	 cd perl-5.28.0 && \
	./Configure -des -Dprefix=/usr/local/perl && \
	make && make test && make install
# install tcl	
RUN wget https://sourceforge.net/projects/tcl/files/Tcl/8.6.8/tcl8.6.8-src.tar.gz && \
	tar -xzvf tcl8.6.8-src.tar.gz && \
	cd  tcl8.6.8/unix/ && \
	./configure   && \
	make && make install	
# install redis	
RUN wget http://download.redis.io/releases/redis-3.2.8.tar.gz && \
	tar -zxvf redis-3.2.8.tar.gz && \
	cd redis-3.2.8 && \
	make && make test && make install
	

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 
ENV PATH=$PATH:$JAVA_HOME/bin

# redis config
COPY config/* /tmp/
RUN mkdir -p /etc/redis && \   
    mkdir -p /var/redis/6379  

#copy redis ��������ļ�
RUN mv /tmp/redis_6379 /etc/init.d/redis_6379 && \
    mv /tmp/6379.conf  /etc/redis/6379.conf && \
    mv /tmp/start-redis.sh  ~/start-redis.sh 
    
##### �޸�redis.conf�еĲ�������Ϊ��������
#daemonize	yes							��redis��daemon��������
#pidfile		/var/run/redis_6379.pid 	����redis��pid�ļ�λ��
#port		6379						����redis�ļ����˿ں�
#dir 		/var/redis/6379				���ó־û��ļ��Ĵ洢λ�� 
#1.���������־
#2.�������� 
#3.����aof�־û�
#4.�־û��ļ����λ��#sed -i 's/dir/dir \/var\/redis\/6379/' /etc/redis/6379.conf  
#5.��127.0.0.1 �ĳ�0.0.0.0 ������������ping��ͨ. redissed -i 's/bind 127\.0\.0\.1/bind 0\.0\.0\.0/' /etc/redis/6379.conf   
RUN sed -i 's/logfile ""/logfile "access.log"/' /etc/redis/6379.conf && \
	  sed -i 's/# requirepass foobared/requirepass 123456/' /etc/redis/6379.conf && \
		sed -i 's/appendonly no/appendonly yes/' /etc/redis/6379.conf   && \
		sed -i 's/bind 127\.0\.0\.1/bind 0\.0\.0\.0/' /etc/redis/6379.conf  
		
#����redis
RUN chmod 777 /etc/init.d/redis_6379 && \
	cd /etc/init.d/ && \
	./redis_6379 start 
	
#update-rc.d redisd defaults ���ÿ����Զ�����ubuntu��д��

RUN update-rc.d redis_6379 defaults

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


EXPOSE 6379

CMD [ "sh", "-c", "service ssh start; bash"]

