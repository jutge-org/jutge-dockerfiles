ARG type=server
# vinga can be 'compile-vinga' or `download-vinga`
ARG vinga=compile-vinga

## base ###########################################################################################
FROM ubuntu AS builder
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive

# Update ubuntu packages
RUN apt-get --yes update && apt-get --yes upgrade

# Set local timezone
RUN apt-get --yes install tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Install initial tools
RUN apt-get --yes install \
    tzdata imagemagick joe nano tree ack wget curl moreutils less adduser sudo git

# Create user 'worker'
RUN adduser --disabled-password --gecos '' worker
ADD inputrc /home/worker/.inputrc
RUN chown -R worker:worker /home/worker

# Fix convert, because it does not generate the eps files
# see https://askubuntu.com/questions/1081695/error-during-converting-jpg-to-pdf
RUN perl -p -i.bak -e 's/domain="coder" rights="none"/domain="coder" rights="read|write"/g' \
    /etc/ImageMagick-6/policy.xml

# Install 
RUN apt install --yes make gcc binutils

# Install Python3
RUN apt-get --yes install python3 python3-pip python3-pillow python3-cairo python3-yaml python3-venv

# Compile 'jutge-vinga' (taking source from the build context) using container compilers 
# and install it. To be able to do this, the source code has to be cloned outside the container, 
# since it is a private repository.

FROM builder AS compile-vinga
RUN --mount=type=bind,source=jutge-vinga,target=/root/jutge-vinga,readwrite \
    make -C /root/jutge-vinga/src && \
    cp /root/jutge-vinga/src/jutge-vinga /usr/local/bin/jutge-vinga && \
    chmod u=rws,g=rs,o=rx /usr/local/bin/jutge-vinga
RUN echo "worker ALL=(ALL) NOPASSWD: /usr/local/bin/jutge-vinga" | \
    (sudo su -c 'EDITOR="tee -a" visudo -f /etc/sudoers.d/worker')

# Download vinga from the last version uploaded
FROM builder AS download-vinga

RUN wget -O /usr/local/bin/jutge-vinga https://github.com/jutge-org/jutge-vinga-bin/raw/master/jutge-vinga-linux
RUN chown root:root /usr/local/bin/jutge-vinga
RUN chmod 700 /usr/local/bin/jutge-vinga

FROM ${vinga} AS base

## lite ###########################################################################################
FROM base AS lite

# LaTeX (lite)
RUN apt-get --yes install texlive-latex-extra texlive-games texlive-pstricks



## server #########################################################################################
FROM base AS server

# Install Clang
RUN apt-get --yes install clang

# Install extra languages
RUN apt-get --yes install algol68g basic256 beef bwbasic chicken-bin libchicken-dev \
    clisp erlang f2c fpc gambc gccgo gdc gfortran ghc gnat gobjc golang gprolog guile-2.2 \
    lua5.3 nodejs ocaml openjdk-11-jdk-headless r-base r-base-core r-base-dev r-cran-vgam \
    r-recommended rhino ruby stalin tcl php-cli rustc crystal

# Zig
ADD https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz /root/zig-linux-x86_64-0.13.0.tar.xz
RUN tar -xJf /root/zig-linux-x86_64-0.13.0.tar.xz -C /opt && \
    mv /opt/zig-linux-x86_64-0.13.0 /opt/zig && \
    rm -f /root/zig-linux-x86_64-0.13.0.tar.xz && \
    echo "export PATH=\$PATH:/opt/zig" >> /home/worker/.profile
ENV PATH="$PATH:/opt/zig"

# Codon
ADD https://exaloop.io/install.sh /root/install-codon.sh
# FIXME: Why install-codon.sh does not return 0?
RUN bash /root/install-codon.sh || true
RUN mv /root/.codon /opt/codon && \
    ln -s /opt/codon/bin/codon /usr/local/bin/codon

# Clojure
ADD https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh /root/install-clojure.sh
RUN bash /root/install-clojure.sh

# Crystal
ADD https://dist.crystal-lang.org/apt/setup.sh /root/install-crystal.sh
RUN bash /root/install-crystal.sh 

# Whitespace
ADD bin/wspace /usr/local/bin/wspace
RUN chmod 755 /usr/local/bin/wspace



## full ##########################################################################################
FROM server AS full

# LaTeX (full)
RUN apt-get --yes install texlive-latex-extra texlive-games texlive-pstricks

# Install Python libraries
RUN mkdir /opt/pylibs && \
    cd /opt/pylibs && \
    for pylib in "numpy scipy simpy networkx optilog pandas matplotlib more-itertools biopython beautifulsoup4"; do \
        echo install $pylib; \
        python3 -m venv $pylib; \
        source $pylib/bin/activate; \
        pip install $pylib; \
        pip show $pylib > $pylib/show.txt; \
        deactivate; \
        chmod 700 $pylib; \
    done



## final #########################################################################################
FROM ${type} AS final

# Install jutge-toolkit and jutge-server-toolkit from source
RUN pip3 install --break-system-packages turtle-pil easyinput yogi pytokr mypy pycodestyle

# Install `jutge-toolkit` and `jutge-server-toolkit` from local submodule
RUN --mount=type=bind,source=jutge-toolkit,target=/root/jutge-toolkit,readwrite \
    --mount=type=bind,source=jutge-server-toolkit,target=/root/jutge-server-toolkit,readwrite \
    # FIXME(pauek): We should fix both packages to conform to new installation format...
    pip3 install --use-pep517 --break-system-packages /root/jutge-toolkit /root/jutge-server-toolkit

# Clear cache
RUN pip3 cache purge
RUN apt-get --yes clean

# Set user
USER worker
WORKDIR /home/worker
ENV USER=worker
ENV LANG=C.UTF-8
