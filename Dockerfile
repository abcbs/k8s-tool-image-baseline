############################################
# version : private.docker.hub:5000/ubuntu:baseline
# desc : 当前版本安装的nmon
############################################
# 设置继承自我们创建的curl,vim镜像
FROM private.docker.hub:5000/ubuntu:baseline

# 下面是一些创建者的基本信息
MAINTAINER LiuJQ

# 设置环境变量，所有操作都是非交互式的
ENV DEBIAN_FRONTEND noninteractive

ENV LANG C.UTF-8
 
#时钟同步节点
ENV NTPSERVER 172.16.1.50 

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV TZ 'Asia/Shanghai'
    
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get -y install ntpdate && \
    apt-get -y install cron && \
    apt-get clean
    


#RUN ntpdate   ${NTPSERVER} \
#    && hwclock --localtime --systohc
    

RUN sed -i '$a0 1 * * * root ntpdate $NTPSERVER;/sbin/hwclock -w' /etc/crontab

# 执行supervisord来同时执行多个命令，使用 supervisord 的可执行路径启动服务。
CMD ["/usr/bin/supervisord"]