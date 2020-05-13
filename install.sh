
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
apt-get --yes install sudo imagemagick joe nano tree wget curl

# Install python3
apt-get --yes install python3 python3-pip python3-pillow python3-cairo python3-yaml

# Install jutge python3 packages
pip3 install jutge jutge-toolkit

# Install jutge-vinga
jutge-install-vinga

# Install common compilers
apt-get --yes install build-essential

# Install exotic compilers
if [ $1 = "full" ] || [ $1 = "server" ] ; then
    apt-get --yes install algol68g basic256 beef bf bwbasic clang chicken-bin libchicken-dev clisp erlang f2c fpc gambc gccgo gdc gfortran ghc gnat gobjc golang gprolog guile-2.0 lua5.3 nodejs ocaml-native-compilers openjdk-8-jdk-headless r-base r-base-core r-base-dev r-cran-vgam  r-recommended rhino ruby stalin tcl php-cli
fi

# Install latex
if [ $1 = "full" ] || [ $1 = "lite" ] ; then
    apt-get --yes install texlive-latex-extra texlive-games texlive-pstricks
fi

# Clean apt
apt-get clean
