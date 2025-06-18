#! /usr/bin/bash

# get the migration tool
git clone https://gitlab.com/hepcedar/lhapdf
mv lhapdf/migration $PREFIX/share/lhapdf/migration

# standard lhapdf5 compilation
FFLAGS="-std=legacy" ./configure --prefix=$PREFIX

make -j$(nproc)
make install
