FROM ivonet/ubuntu:18.04 AS builder

#https://download-cf.jetbrains.com/python/pycharm-professional-2019.3.1.tar.gz
#https://download-cf.jetbrains.com/python/pycharm-community-2019.3.1.dmg

RUN /usr/bin/curl -s -L "https://download-cf.jetbrains.com/python/pycharm-community-2019.3.1.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/pycharm* /opt/pycharm

FROM ivonet/x11webui:1.0

COPY --from=builder /opt/pycharm /opt/pycharm

#Fix:
#       Warning **: Error retrieving accessibility bus address:
#https://www.raspberrypi.org/forums/viewtopic.php?t=196070

RUN apt-get update -qq -y \
 && apt-get install -y --no-install-recommends \
        python3\
        python3-examples \
        python3-venv \
        python3-pip \
        git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY root/ /

ARG APP=PyCharm
ARG USR=user
ARG PWD=secret

ENV IDE_HOME=/opt/pycharm                               \
    IDE_BIN_HOME=/opt/pycharm/bin                       \
    VM_OPTIONS_FILE=/opt/pycharm/bin/pycharm.vmoptions  \
    APPNAME=$APP                                        \
    USERNAME=$USR                                       \
    PASSWORD=$PWD

WORKDIR /project
VOLUME /project
