# nodejs image
#
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
#
FROM    builder:node-amd64-centos

#
# Build Time Arguments
#
ARG NAME
ARG APP_ROOT
ARG NODE_VERSION
ARG NODE_SHORT_REPO
ARG YARN_VERSION
ARG NODE_SVC_NAME
ARG NODE_SVC_UID

# Do some bookeeping for the repository and openshift
#
#
# It is deprecated but guess what...There are a lot of tools that still use it
#
MAINTAINER ignidis(at)cybearth(dot)net (https://github.com/ignidis/node-docker)

#
# And this is for those new tools
#
LABEL summary="Platform for running ${NAME}-${NODE_SHORT_REPO}-${NODE_VERSION} or building ${NAME}-based applications" \
      description="${NAME} is an asynchronuous event driven JavaScript runtime built on Chrome's V8 JavaScript engine" \
      io.k8s.description="${NAME} is an asynchronuous event driven JavaScript runtime built on Chrome's V8 JavaScript engine" \
      io.k8s.display-name="NODE-${NODE_SHORT_REPO}-${NODE_VERSION}" \
      io.openshift.tags="builder,${NAME},${NAME}-${NODE_SHORT_REPO}-${NODE_VERSION}" \
      name="${NAME}" \
      version="${NODE_VERSION}-amd64-centos" \
      maintainer="ignidis(at)cybearth(dot)net" \
      help="For more information visit https://github.com/ignidis/node-docker" \
      usage="s2i build <SOURCE-REPOSITORY> ${NAME}:${NODE_VERSION}-amd64-centos <APP-NAME>"

#
#
# Setup runtime variables
#
ENV PATH=${APP_ROOT}/bin:${APP_ROOT}/node/bin:${APP_ROOT}/yarn/bin:${PATH} \
    HOME=/var/lib/node

EXPOSE 9615
VOLUME [${HOME}]

# Set start command
#
# Change the user to the unprivileged node user and start node as such
#
USER    ${NODE_SVC_UID}
WORKDIR ${APP_ROOT}

ENTRYPOINT [ "bin/init" ]
CMD     ["pm2-runtime","--web","--no-auto-exit","/etc/node.pm2/services.config.js"]
#CMD     ["bash"]