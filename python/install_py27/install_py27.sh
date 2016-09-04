#!/bin/sh
#install py27 pip

[ -d /data/tools/ ] || mkdir -p /data/tools
cd /data/tools

wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz

yum install gcc openssl openssl-devel python-devel sqlite-devel readline readline-devel patch mlocate -y
tar xf Python-2.7.12.tgz
cd Python-2.7.12
./configure
make
make install

cd /data/tools
wget https://bootstrap.pypa.io/ez_setup.py -O - | python2.7
wget https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
