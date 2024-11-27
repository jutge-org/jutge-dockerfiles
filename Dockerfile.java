FROM jutgeorg/base:latest
USER root
RUN apt-get --yes --no-install-recommends install openjdk-17-jdk-headless

RUN apt-get --yes --no-install-recommends install kotlin

# Required for clj to work
RUN apt-get --yes --no-install-recommends install rlwrap
ADD https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh /root/install-clojure.sh
RUN bash /root/install-clojure.sh

#Make sure clojure downloads the libraries it needs
RUN mkdir /clojure
WORKDIR /clojure

RUN echo '{:paths ["src"]}' > deps.edn
RUN mkdir src
RUN echo '(ns core)\n\n(println "Hello, World")' > src/core.clj
RUN clj -M 
RUN mv /root/.m2/repository/ /clojure/.m2

RUN chmod -R o+r /clojure/

RUN rm /clojure/deps.edn
RUN rm /clojure/src -rf

USER worker
WORKDIR /home/worker
