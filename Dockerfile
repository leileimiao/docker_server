FROM ubuntu:18.04

MAINTAINER Honglei Zhang <zhanghonglei1997@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive  NOTVISIBLE="in users profile"
COPY --chown=root ./docker_entrypoint.sh /home
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN  sed -i s@/archive.ubuntu.com/@/mirror.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
&& sed -i s@/security.ubuntu.com/@/mirror.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
RUN apt-get update &&  apt-get install -y \
    gcc \
    gcc-multilib \
    perlbrew \
    sudo \
    openssh-server \
    make \
    gcc-4.8\
    gcc-4.8-multilib\
    build-essential \
    python2.7 \
    valgrind 3.2.1 \
    bsdmainutils \
    diffutils \
    curl \
    tcl8.5 \
    tcl8.5-dev \
    tk8.5-dev \
    tk8.5 \
    bison \
    flex \
    git \
&& apt-get clean


RUN dpkg-reconfigure -f noninteractive tzdata \
&& mkdir /var/run/sshd \ 
&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
&& echo "export VISIBLE=now" >> /etc/profile
ENTRYPOINT ["/home/docker_entrypoint.sh"]
EXPOSE 22
CMD ["-u test -p test"]

