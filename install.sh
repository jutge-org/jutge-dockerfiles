#echo commands
set -x

# Update and upgrade apt packages
apt-get --yes update
apt-get --yes upgrade

# Install initial tools
apt-get --yes install imagemagick joe nano tree ack wget curl moreutils less adduser sudo

# Add users
adduser --disabled-password --gecos '' worker
adduser --disabled-password --gecos '' worker1
adduser --disabled-password --gecos '' worker2
adduser --disabled-password --gecos '' worker3
adduser --disabled-password --gecos '' worker4
adduser --disabled-password --gecos '' worker5
adduser --disabled-password --gecos '' worker6
adduser --disabled-password --gecos '' worker7
adduser --disabled-password --gecos '' worker8
adduser --disabled-password --gecos '' worker9

# Copy .inputrc to worker
cp /root/.inputrc /home/worker
chown -R worker:worker /home/worker

# Set timezone
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
export DEBIAN_FRONTEND=noninteractive
apt-get install --yes tzdata
ln -fs /usr/share/zoneinfo/Europe/Andorra /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Install C compilers
apt-get --yes install build-essential clang

# Install python3
apt-get --yes install python3 python3-pip python3-pillow python3-cairo python3-yaml python3-venv

# Install python3 jutge packages
pip3 install jutge-toolkit jutge-server-toolkit turtle-pil easyinput yogi pytokr

# Install more python3 packages
pip3 install mypy pycodestyle

# Install jutge sudo tools
jutge-install-sudo-tools

# Install exotic compilers
if [[ $1 = "full" ]] || [[ $1 = "server" ]] ; then

    apt-get --yes install algol68g basic256 beef bwbasic chicken-bin libchicken-dev clisp erlang f2c fpc gambc gccgo gdc gfortran ghc gnat gobjc golang gprolog guile-2.2 lua5.3 nodejs ocaml openjdk-11-jdk-headless r-base r-base-core r-base-dev r-cran-vgam r-recommended rhino ruby stalin tcl php-cli rustc

    # does not work: nim
    # does not work: bf

    # Install codon
    /bin/bash -c "$(curl -fsSL https://exaloop.io/install.sh)"
    mv /root/.codon /opt/codon
    ln -s /opt/codon/bin/codon /usr/local/bin/codon

    # Install clojure
    /bin/bash -c "$(curl -fsSL https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh)"

    # Install crystal
    /bin/bash -c "$(curl -fsSL https://dist.crystal-lang.org/apt/setup.sh)"
fi

# Fix wspace protections
chmod 755 /usr/local/bin/wspace

# Install latex
if [[ $1 = "full" ]] || [[ $1 = "lite" ]] ; then
    apt-get --yes install texlive-latex-extra texlive-games texlive-pstricks
fi

# Fix convert, because it does not generate the eps files
# see https://askubuntu.com/questions/1081695/error-during-converting-jpg-to-pdf
perl -p -i.bak -e 's/domain="coder" rights="none"/domain="coder" rights="read|write"/g' /etc/ImageMagick-6/policy.xml

# Install python problem libraries
if [[ $1 = "full" ]] || [[ $1 = "server" ]] ; then

    mkdir /opt/pylibs
    cd /opt/pylibs

    pylibs="numpy scipy simpy networkx optilog pandas matplotlib more-itertools biopython beautifulsoup4"
    for pylib in $pylibs
    do
        echo install $pylib
        python3 -m venv $pylib
        source $pylib/bin/activate
        pip install $pylib
        pip show $pylib > $pylib/show.txt
        deactivate
        chmod 700 $pylib    # protect the lib
    done

	# Make the worker own the libraries (avoid errors later)
	chown -R worker:worker /opt/pylibs
fi

# Clean shit
pip3 cache purge
apt-get clean
