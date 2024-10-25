FROM jutgeorg/base:latest
USER root
RUN apt update && apt --yes install openjdk-17-jdk-headless
ADD https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh /root/install-clojure.sh
RUN bash /root/install-clojure.sh

RUN apt update && apt install --yes kotlin

USER worker
