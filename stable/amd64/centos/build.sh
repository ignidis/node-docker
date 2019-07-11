#!/bin/bash
#
# docker build node image
# Usage:
#        [sudo] build.sh <node-lts-version> <yarn-version> <registry> <registry-user> <registry-pwd> <project>
#
# Must run as superuser, either you are root or must sudo 
#
# Create the multilayered main docker image containing the application and all helper settings 
#
docker build --build-arg NAME="NODE" --build-arg APP_ROOT="/opt" --build-arg NODE_VERSION="$1" --build-arg NODE_SHORT_REPO="LTS" --build-arg YARN_VERSION="$2" --build-arg NODE_SVC_NAME="node" --build-arg NODE_SVC_UID="9003" --rm -t builder:ml-node-amd64-centos --file ./Builderfile . && \
#
# Start an efemeral container using the just created image, the command in the Builderfile makes sure nothing is setup or starts
#
docker run --rm -it -d --name builder-node-amd64-centos builder:ml-node-amd64-centos bash && \
#
# Export the container file system as data stream and import into a new docker image. This flatens the image
#
docker export builder-node-amd64-centos | docker import - builder:node-amd64-centos && \
#
# Stop the container, it will be removed automatically (see --rm flag above)
#
docker kill builder-node-amd64-centos && \
#
# Now use the flat image to create the final image, we only add meta information
#
docker build --build-arg NAME="NODE" --build-arg APP_ROOT="/opt" --build-arg NODE_VERSION="$1" --build-arg NODE_SHORT_REPO="LTS" --build-arg YARN_VERSION="$2" --build-arg NODE_SVC_NAME="node" --build-arg NODE_SVC_UID="9003" --rm -t "$3"/"$6"/node:"$1"-amd64-centos . && \
#
# Clean the intermediate image and layers
#
docker rmi builder:ml-node-amd64-centos builder:node-amd64-centos && \
#
# log into the remote registry (if you use one, if not just ignore)
#
docker login -p "$5" -u "$4" "$3" && \
#
# push the final image to the remote registry
#
docker push "$3"/"$6"/node:"$1"-amd64-centos && \
#
# and do the final cleanup remvoing the pushed image
#
docker rmi "$3"/"$6"/node:"$1"-amd64-centos
