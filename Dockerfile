FROM ivonet/ubuntu:22.04 AS builder

RUN /usr/bin/curl -s -L "https://download.jetbrains.com/python/pycharm-community-2022.1.tar.gz" | /bin/tar xz -C /opt/ \
 && mv -v /opt/pycharm* /opt/pycharm

FROM ivonet/web-vnc:1.0_22.04

COPY --from=builder /opt/pycharm /opt/pycharm

RUN apt-get update -qq -y \
 && apt-get install -y --no-install-recommends \
        python3\
        python3-examples \
        python3-venv \
        python3-pip \
        git \
        openjdk-11-jdk \
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
