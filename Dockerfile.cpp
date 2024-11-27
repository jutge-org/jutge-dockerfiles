FROM jutgeorg/base:latest
USER root
RUN apt-get install --no-install-recommends -y clang gcc g++
USER worker