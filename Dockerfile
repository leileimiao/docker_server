FROM ubuntu:18.04

MAINTAINER Honglei Zhang <zhanghonglei1997@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive  NOTVISIBLE="in users profile"
RUN groupadd -r test && useradd -m -s /bin/bash -r -g test test \
&& echo 'test:test' | chpasswd  
# && passwd -e test # force user to change initial password
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN  sed -i s@/archive.ubuntu.com/@/mirror.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
&& sed -i s@/security.ubuntu.com/@/mirror.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
RUN apt-get update &&  apt-get install -y \
    gcc-multilib \
    sudo \
    openssh-server \
    make \
    build-essential \
    python2.7 \
    valgrind 3.2.1 \
    bsdmainutils \
    diffutils \
    curl \
    #tcl8.5 \
    tcl \
   # tcl8.5-dev \
    tcl-dev \
   # tk8.5-dev \
    tk-dev \
   # tk8.5 \
    tk \
    bison \
    flex \
    git \
&& apt-get clean


RUN dpkg-reconfigure -f noninteractive tzdata \
&& usermod -aG sudo test \
&& mkdir /var/run/sshd \ 
&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
&& echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

