# node-docker

A node image including yarn as package manager and pm2 as process manager.
Designed to host multiple node applications; this is Non canon, but saves host memory, use at your own discretion. You can also use to host a single service.
The image is openshift ready and can also be used in a conventional Docker environment.

The builder uses a container to flatten the image layers.
