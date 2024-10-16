FROM jutgeorg/base:latest
USER root
RUN apt install -y clang gcc g++
USER worker