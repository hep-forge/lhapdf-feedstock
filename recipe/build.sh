#! /usr/bin/bash

./configure --prefix=${PWD}/install

make -j
make install
