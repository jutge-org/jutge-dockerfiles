#!/usr/bin/env bash

# Allow the docker daemon to start
sleep 2

# Pull the images
docker pull gcc
docker pull silkeh/clang

# We remove /var/run/docker.pid because the container image is saved and 
# upon restarting the container, the docker daemon will not start
# because it finds this file, which tells it that another daemon is running,
# which is incorrect.
rm -f /var/run/docker.pid