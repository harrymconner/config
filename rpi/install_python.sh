#!/bin/bash

if [[ "$#" -ne 1 ]]
then
  echo "please enter a full python version in the major.minor.patch format"
  exit 1
fi

if ! [[ "$1" =~ ^[[:digit:]]{1,2}\.[[:digit:]]{1,2}\.[[:digit:]]{1,3}$ ]]
then
  echo "python version must be in the format major.minor.patch. $1 is not a valid format."
  exit 2
fi

PYTHON_VERSION=$1

# make sure source package sources are uncommented
sudo sed -i 's/^#[[:space:]]*deb-src/deb-src/g' /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade

# install dependencies that are missing on rpi
sudo apt-get install zlib1g libssl-dev

# python build dependencies
# https://devguide.python.org/getting-started/setup-building/#install-dependencies
sudo apt-get build-dep python3
sudo apt-get install build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev libmpdec-dev

wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
if [ $? -ne 0 ]; then
    exit 1
fi

tar -xf Python-$PYTHON_VERSION.tgz
cd Python-$PYTHON_VERSION

# make sure zlibmodule.c gets compiled and is linked to the zlib library
sed -i 's/^#[[:space:]]*zlib[[:space:]]*zlibmodule/zlib zlibmodule/g' ./Modules/Setup
./configure --enable-optimizations --with-ensurepip=install
make -j -l $(nproc)
sudo make altinstall

cd ..
rm Python-$PYTHON_VERSION.tgz
sudo rm -rf Python-$PYTHON_VERSION

