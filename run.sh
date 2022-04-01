#!/usr/bin/env bash

HUB=ivonet
#HUB=192.168.2.3:5555


docker run                             \
    -it                                \
    --rm                               \
    --name pycharm                     \
    -p 32000:32000                     \
    -p 8080:8080                       \
    -p 5901:5901                       \
    -e AUTH=${AUTH:-false}             \
    -e WIDTH=1920                      \
    -e HEIGHT=1080                     \
    -v $(pwd)/:/project                \
    ${HUB}/pycharm


#-v ${HOME}/.config/ivonet/docker/.PyCharmCE2019.3:/nobody/.PyCharmCE2019.3 \