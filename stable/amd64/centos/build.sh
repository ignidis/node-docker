#!/bin/bash
#
# docker build node image
# Usage:
#        [sudo] build.sh <node-lts-version> <yarn-version> <registry> <registry-user> <registry-pwd> <project>
#
# Must run as superuser, either you are root or must sudo 
#
docker build --build-arg NAME="NODE" --build-arg APP_ROOT="/opt" --build-arg NODE_VERSION="$1" --build-arg NODE_SHORT_REPO="LTS" --build-arg YARN_VERSION="$2" --build-arg NODE_SVC_NAME="node" --build-arg NODE_SVC_UID="9003" --rm -t builder:ml-node-amd64-centos --file ./Builderfile . && \
docker run --rm -it -d --name builder-node-amd64-centos builder:ml-node-amd64-centos bash && \
docker export builder-node-amd64-centos | docker import - builder:node-amd64-centos && \
docker kill builder-node-amd64-centos && \
docker build --build-arg NAME="NODE" --build-arg APP_ROOT="/opt" --build-arg NODE_VERSION="$1" --build-arg NODE_SHORT_REPO="LTS" --build-arg YARN_VERSION="$2" --build-arg NODE_SVC_NAME="node" --build-arg NODE_SVC_UID="9003" --rm -t "$3"/"$6"/node:"$1"-amd64-centos . && \
docker rmi builder:ml-node-amd64-centos builder:node-amd64-centos && \
docker login -p "$5" -u "$4" "$3" && \
docker push "$3"/"$6"/node:"$1"-amd64-centos && \
docker rmi "$3"/"$6"/node:"$1"-amd64-centos
