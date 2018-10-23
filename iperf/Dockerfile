############################################
# version : private.docker.hub:5000/ubuntu:env
# desc : 容器基础环境
############################################
# 设置继承自我们创建的 tools 镜像
FROM private.docker.hub:5000/ubuntu:dev-t8

# 下面是一些创建者的基本信息
MAINTAINER LiuJQ

RUN apt-get update \
    && apt-get -y install gcc \
    && apt-get -y install make \
    && apt-get -y install g++

# 设置环境变量，所有操作都是非交互式的
#ENV DEBIAN_FRONTEND noninteractive

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get update \
    && apt-get install -y iperf3 \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5201

#执行supervisord来同时执行多个命令，使用supervisord的可执行路径启动服务。
CMD ["/usr/bin/supervisord"]
#ENTRYPOINT ["iperf3"]

