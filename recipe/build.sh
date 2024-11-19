#! /usr/bin/bash

FFLAGS="-std=legacy" ./configure --prefix=$PREFIX

make -j$(nproc)
make install
