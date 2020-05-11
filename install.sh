
# Install jutge-vinga
chmod +x /usr/local/bin/jutge-vinga
chmod +s /usr/local/bin/jutge-vinga
ls -la /usr/local/bin/jutge-vinga

# Install jutge-start
chmod +x /usr/local/bin/jutge-start
ls -la /usr/local/bin/jutge-start

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

# Update and upgrade apt-get packages
apt-get --yes update
apt-get --yes upgrade

# Set timezone
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
export DEBIAN_FRONTEND=noninteractive
apt-get install --yes tzdata
ln -fs /usr/share/zoneinfo/Europe/Andorra /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Install common tools
apt-get --yes install imagemagick joe nano python python-pip python-pillow python-cairo python-yaml tree wget

# Install common python packages
pip install jutge jutge-toolkit

# Install common compilers
apt-get --yes install build-essential

# Install exotic compilers
if [ $1 = "full" ] || [ $1 = "server" ] ; then
    apt-get --yes install algol68g basic256 beef bf bwbasic clang chicken-bin libchicken-dev clisp erlang f2c fpc gambc gccgo gdc gfortran ghc gnat gobjc golang gprolog guile-2.0 lua5.3 nodejs ocaml-native-compilers openjdk-8-jdk-headless r-base r-base-core r-base-dev r-cran-vgam  r-recommended rhino ruby stalin tcl php-cli
fi

# Install latex
if [ $1 = "full" ] || [ $1 = "lite" ] ; then
    # TODO: Remove this commented code for testing!
    echo apt-get --yes install texlive-latex-extra texlive-games texlive-pstricks
fi

# Clean apt
apt-get clean
