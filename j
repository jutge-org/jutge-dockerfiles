#!/bin/bash

if [ -z "$1" ];
then
    echo You must at least specify one argument!
    exit
fi



for jutge_version in jutge-server jutge-full jutge-lite;
do
    ver=$(sudo docker image ls | awk '{print $1}' | grep $jutge_version)
    if [ "$ver" ];
    then
	selected_ver=$ver
        break
    fi
done

if [ -z "$selected_ver" ];
then
    echo No jutge docker image was found! I will download jutge-lite...
    selected_ver='jutge-lite'
fi



if [ $1 == 'submit' ];
then
    docker run --rm -i jutge-lite $@
else
    docker run --rm -t -v $(pwd):/home/worker jutge-lite $@
fi
