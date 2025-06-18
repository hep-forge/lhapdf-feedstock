#! /usr/bin/bash

# get the 
git clone https://gitlab.com/hepcedar/lhapdf
mv lhapdf/migration $PREFIX/share/lhapdf/migration

FFLAGS="-std=legacy" ./configure --prefix=$PREFIX

make -j$(nproc)
make install
