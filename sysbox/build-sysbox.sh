#!/usr/bin/env bash

# Build the image with Docker inside
docker build -t jutge-sysbox -f Dockerfile.sysbox .

# Remove if present
docker container rm sysbox_with_images || true

# Run the container to install the docker images inside
docker run -it --runtime=sysbox-runc --name sysbox_with_images jutge-sysbox /root/install-docker-images.sh

# Alter the image with the container content
docker commit sysbox_with_images jutge-sysbox:with-images