#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

VERSION=$(<VERSION)
#FROM=$(<FROM)
SPECIFIC_FILE=Dockerfile.specific
IMAGE_NAME=homebridge-v$VERSION
DOCKER_NAME=homebridge-kasa
SED_COMMAND="sed -i '.bak' \"/#####SPECIFIC#####/ r $SPECIFIC_FILE\" Dockerfile"


ACTION=$1

if [ -z "$ACTION" ];
  then
    echo "usage: $0 <build|run|stop|start|remove|rerun|attach|logs>";
    exit 1;
fi

_build() {
  # Generate Dockerfile
  #echo $FROM > Dockerfile
  #cat Dockerfile.common >> Dockerfile
  #eval $SED_COMMAND

  # Build
  docker build --tag="$DOCKER_NAME:$VERSION" .
}

_run() {
  # Run (first time)
  docker run -d -p 0.0.0.0:51826:51826 -v /etc/homebridge:/root/.homebridge --net=host --name $IMAGE_NAME $DOCKER_NAME:$VERSION
}

_stop() {
  # Stop
  docker stop $IMAGE_NAME
}

_start() {
  # Start (after stopping)
  docker start $IMAGE_NAME
}

_remove() {
  # Remove
  docker rm $IMAGE_NAME
}

_rerun() {
  _stop
  _remove
  _run
}

_attach() {
  docker exec -ti $IMAGE_NAME bash
}

_logs() {
  docker logs $IMAGE_NAME
}

eval _$ACTION