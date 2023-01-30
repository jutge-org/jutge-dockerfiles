FROM ubuntu

ARG type
# type can be full, lite, test or server
# to pass it: docker build -t some-name . --build-arg type=full

COPY install.sh /root/

COPY _inputrc /root/.inputrc

WORKDIR /root

RUN /bin/bash /root/install.sh $type

USER worker

WORKDIR /home/worker

ENV USER worker

ENV LANG C.UTF-8
