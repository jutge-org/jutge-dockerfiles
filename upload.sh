#!/bin/bash

echo -n "New version? "
read version


make lite

docker image tag jutge-lite:latest jutgeorg/jutge-lite:$version
docker image tag jutge-lite:latest jutgeorg/jutge-lite:latest

docker push jutgeorg/jutge-lite:$version
docker push jutgeorg/jutge-lite:latest

docker image rm jutge-lite
docker image rm jutgeorg/jutge-lite:$version


make server

docker image tag jutge-server:latest jutgeorg/jutge-server:$version
docker image tag jutge-server:latest jutgeorg/jutge-server:latest

docker push jutgeorg/jutge-server:$version
docker push jutgeorg/jutge-server:latest

docker image rm jutge-server
docker image rm jutgeorg/jutge-server:$version
