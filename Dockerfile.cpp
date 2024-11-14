FROM jutgeorg/base:latest
USER root
RUN apt install --no-install-recommends -y clang gcc g++
USER worker