FROM ubuntu

ARG type
# type can be full, lite, test or server
# to pass it: docker build -t some-name . --build-arg type=full

COPY install.sh /root/

COPY _inputrc /root/.inputrc

COPY wspace /usr/local/bin

WORKDIR /root

# FIXME(pauek): We should not use an external script.
#
# Any command that needs to be run to build the image should be in the 
# Dockerfile, not in a script. The reason for this is that Docker will hash each
# change as a separate layer, and then those can be shared between 
# images.
#
# Right now all 4 images are the same until running `install.sh`.
# If there are common parts, they should run first, and then as the last
# modifications, do what's specific of each one. If there are dependencies
# between steps, then we can use `FROM` instructions to start from a previous
# step.
#
RUN /bin/bash /root/install.sh $type 2>&1 | tee /root/install.txt

USER worker

WORKDIR /home/worker

ENV USER=worker

ENV LANG=C.UTF-8
