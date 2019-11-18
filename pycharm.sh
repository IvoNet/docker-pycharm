#!/usr/bin/env bash
NAME=pycharm
PORT=11000
WAIT=5

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
        -v /Users/ivonet/dev/docker-pycharm/projects:/nobody/PycharmProjects \
        -v /Users/ivonet/.config/ivonet/docker/.PyCharmCE2019.2:/nobody/.PyCharmCE2019.2 \
        ivonet/pycharm

    sleep $WAIT
    open http://localhost:$PORT
else
    echo "Stopping PyCharm..."
    docker stop $NAME
fi
