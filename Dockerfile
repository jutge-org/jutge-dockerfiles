FROM ubuntu

ARG type
# type can be full, lite or server
# to pass it: docker build -t some-name . --build-arg type=full

COPY jutge-vinga /usr/local/bin/
COPY jutge-submit.sh /usr/local/bin/jutge-submit
COPY jutge-start.py /usr/local/bin/jutge-start
COPY install.sh /root/
COPY _inputrc /root/.inputrc

WORKDIR /root
RUN /bin/bash /root/install.sh $type

USER worker
WORKDIR /home/worker/
COPY _inputrc /home/worker/.inputrc

ENV USER worker
ENV LANG C.UTF-8
