FROM ubuntu

ARG type
# type can be full, lite or server
# to pass it: docker build -t some-name . --build-arg type=full

COPY vinga64 /usr/bin/
COPY submit /usr/local/bin/
COPY install.sh /root/

WORKDIR /root
RUN /bin/bash /root/install.sh $type

WORKDIR /home/worker/
