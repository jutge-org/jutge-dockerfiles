#!/bin/bash
python_libraries=$@

mkdir /opt/pylibs
cd /opt/pylibs
for pylib in $python_libraries; do
    echo install $pylib
    python3 -m venv $pylib
    source $pylib/bin/activate
    pip install $pylib
    pip show $pylib > $pylib/show.txt
    deactivate
    chmod 700 $pylib    # protect the lib
done