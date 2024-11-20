FROM jutgeorg/base:latest
USER root
RUN apt --yes update && apt --yes upgrade && apt --yes install clang gcc g++
USER worker