#/usr/bin/env bash

echo install pylib $1
python3 -m venv $1
. $1/bin/activate
pip install $1 
pip show $1 > $1/show.txt
