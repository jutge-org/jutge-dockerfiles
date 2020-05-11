#!/bin/bash

# dins del guest
# es fa servir amb pipes
# ajuntar submit i com


name=$1
ulimit -t 310
umask 077
mkdir $name
cd $name
tar xf -
chmod -R u+rwX, go-rwx .
jutge-start $name
cd correction
tar czf - *
cd ../..
rm -rf $name
