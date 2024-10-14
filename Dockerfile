FROM ubuntu:22.04

ARG type
# type can be full, lite, test or server
# to pass it: docker build -t some-name . --build-arg type=full

COPY install.sh /root/

COPY _inputrc /root/.inputrc

COPY wspace /usr/local/bin

WORKDIR /root

RUN /bin/bash /root/install.sh $type 2>&1 | tee /root/install.txt

USER worker

WORKDIR /home/worker

ENV USER=worker

ENV LANG=C.UTF-8
