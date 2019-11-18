#!/usr/bin/env bash
HUB=ivonet
#HUB=192.168.2.3:5555
image=pycharm
version=2019.2.4

deploy=false
#deploy=true
versioning=false
#versioning=true

#OPTIONS="$OPTIONS --no-cache"
#OPTIONS="$OPTIONS --force-rm"
OPTIONS="$OPTIONS --build-arg APP=PyCharm --build-arg USR=ivonet --build-arg PWD=secret"

docker build ${OPTIONS} -t $HUB/${image}:latest .
if [ "$?" -eq 0 ] && [ ${deploy} == "true" ]; then
    docker push $HUB/${image}:latest
fi

if [ "$versioning" = true ]; then
    docker tag $HUB/${image}:latest $HUB/${image}:${version}
    if [ "$?" -eq 0 ] && [ ${deploy} == "true" ]; then
        docker push $HUB/${image}:${version}
    fi
fi
