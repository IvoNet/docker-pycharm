#!/usr/bin/env bash
NAME=pycharm
PORT=11000
WAIT=3

if [ ! "$(docker ps -q -f name=$NAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$NAME)" ]; then
        echo "Starting existing PyCharm config..."
        docker start $NAME
        sleep $WAIT
        open http://localhost:$PORT
        exit 0
    fi
    echo "Starting new PyCharm config..."
    docker run                                                    \
        -d                                                        \
        --name $NAME                                              \
        -p $PORT:32000                                            \
        -p 8080:8080                                              \
        -p 5901:5901                                              \
        -e AUTH=${AUTH:-false}                                    \
        -e WIDTH=1920                                             \
        -e HEIGHT=1080                                            \
        -v ${HOME}/dev/docker-pycharm/projects:/nobody/PycharmProjects \
        -v ${HOME}/.config/ivonet/docker/.PyCharm:/nobody/.config/JetBrains/PyCharmCE2021.3 \
        ivonet/pycharm

    sleep $WAIT
    open http://localhost:$PORT
else
    echo "Stopping PyCharm..."
    docker stop $NAME
fi
