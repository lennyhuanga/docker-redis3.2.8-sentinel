�γ̴��

1����װ������redis
2��redis������������������
3��redis cli��ʹ��

------------------------------------------------------------------------

1����װ������redis

��ҿ����Լ�ȥ�������أ���ȻҲ�����ÿγ��ṩ��ѹ����

wget http://downloads.sourceforge.net/tcl/tcl8.6.1-src.tar.gz
tar -xzvf tcl8.6.1-src.tar.gz
cd  /usr/local/tcl8.6.1/unix/
./configure  
make && make install

ʹ��redis-3.2.8.tar.gz����ֹ2017��4�µ������ȶ��棩
wget http://download.redis.io/releases/redis-3.2.8.tar.gz && \
tar -zxvf redis-3.2.8.tar.gz
cd redis-3.2.8
make && make test && make install

------------------------------------------------------------------------

2��redis������������������

���һ���ѧϰ�γ̣���������redis-server����һ��redis����һЩʵ�飬�����Ļ���ûʲô����

Ҫ��redis��Ϊһ��ϵͳ��daemon����ȥ���еģ�ÿ��ϵͳ������redis����һ������

��1��redis utilsĿ¼�£��и�redis_init_script�ű�
��2����redis_init_script�ű�������linux��/etc/init.dĿ¼�У���redis_init_script������Ϊredis_6379��6379������ϣ�����redisʵ�������Ķ˿ں�
��3���޸�redis_6379�ű��ĵ�6�е�REDISPORT������Ϊ��ͬ�Ķ˿ںţ�Ĭ�Ͼ���6379��
��4����������Ŀ¼��/etc/redis�����redis�������ļ�����/var/redis/6379�����redis�ĳ־û��ļ���
��5���޸�redis�����ļ���Ĭ���ڸ�Ŀ¼�£�redis.conf����������/etc/redisĿ¼�У��޸�����Ϊ6379.conf
��6���޸�redis.conf�еĲ�������Ϊ��������

daemonize	yes							��redis��daemon��������
pidfile		/var/run/redis_6379.pid 	����redis��pid�ļ�λ��
port		6379						����redis�ļ����˿ں�
dir 		/var/redis/6379				���ó־û��ļ��Ĵ洢λ��

��7������redis��ִ��cd /etc/init.d, chmod 777 redis_6379��./redis_6379 start

��8��ȷ��redis�����Ƿ�������ps -ef | grep redis

��9����redis����ϵͳ�����Զ�����

centos����redis_6379�ű��У������棬��������ע��

# chkconfig:   2345 90 10

# description:  Redis is a persistent key-value database

chkconfig redis_6379 on

ubuntu �У�update-rc.d redisd defaults

------------------------------------------------------------------------

3��redis cli��ʹ��

redis-cli SHUTDOWN�����ӱ�����6379�˿�ֹͣredis����

redis-cli -h 127.0.0.1 -p 6379 SHUTDOWN���ƶ�Ҫ���ӵ�ip�Ͷ˿ں�

redis-cli PING��ping redis�Ķ˿ڣ����Ƿ�����

redis-cli�����뽻��ʽ������

SET k1 v1
GET k1

redis�ļ���������4��

redis�������ݽṹ�������ʹ�ã�����java api��ʹ��
redisһЩ����Ľ��������ʹ�ã�pub/sub��Ϣϵͳ���ֲ�ʽ����������Զ���ɣ��ȵ�
redis�ճ��Ĺ�����ص�����
redis��ҵ���ļ�Ⱥ����ͼܹ�

�������׿γ̣�ʵ�����������ҵ���Ĵ��ͻ���ܹ����õ���Ŀ����ʵ�Ĵ��͵�����վ������ҳϵͳ�����棩

�������Ƚ���ĵ�һ�飬��ʵ������ҵ���Ĵ��ͻ���ܹ��еģ�redis��Ⱥ�ܹ����������ݡ��߲������߿��ã����������У�����õķֲ�ʽ����ϵͳ

������������Ʒ����ҳϵͳ��ҵ�񿪷���ʱ�򣬵�ȻҲ��ȥ��redis��һЩ����

redis����֪ʶ���̳̣��鼮����Ƶ

redis�־û������Ӽܹ�������ԭ����Ⱥ�ܹ������ݷֲ�ʽ�洢ԭ���ڱ�ԭ���߿��üܹ�

����һЩredis�Ľ̳̣��־û�����Ⱥ���ڱ���Ҳ���ˣ����Ƿ����������򵥴���һ��

�һ����뼯Ⱥ�ܹ��ĵײ�ԭ���ڱ��ĵײ�ԭ����һ�ߵľ��飬�����㣬redis�Ĵ��ģ�ļܹ�ʦ���ȥ֧�ź������ݡ��߲������߿��õ�
