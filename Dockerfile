FROM centos:7.2.1511

LABEL Author="Pad0y<github.com/Pad0y>"

RUN yum install kde-l10n-Chinese -y
RUN yum install glibc-common -y
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
RUN export LANG=zh_CN.UTF-8
RUN echo "export LANG=zh_CN.UTF-8" >> /etc/locale.conf
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

COPY . /data/project/
WORKDIR /data/project/

RUN yum -y update \
    && yum -y install gcc gcc-c++ wget make git libSM-1.2.2-2.el7.x86_64 libXrender libXext\
    && yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel \
    && yum -y install python3-devel centos-release-scl scl-utils-build \
    && yum -y install  devtoolset-7-gcc* \
    && echo 'source /opt/rh/devtoolset-7/enable' >> ~/.bash_profile \
    && source ~/.bash_profile \
    && scl enable devtoolset-7 bash 


RUN pip3 install --user  -U pip -i https://pypi.tuna.tsinghua.edu.cn/simple/  \ 
    && pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/ 


RUN source ~/.bash_profile && pip3 install -r requirements.txt

EXPOSE 8089

CMD python3 backend/main.py