##常见错误
处理：/var/redis/run/redis_6379.pid exists, process is already running or crashed 2017年01月21日 23:02:15 阅读数：13104 命令;service redis start

/var/redis/run/redis_6379.pid exists, process is already running or crashed

引起这类问题一般都是强制关掉电源或断电造成的，也是没等linux正常关机

科学的处理办法2种

 1：可用安装文件启动     redis-server /etc/redis/6379.conf
2：shutdown -r now 软重启让系统自动恢复下就行了

注：网上的说法不可取，不要改动任何文件，其实什么配置等变化都没有