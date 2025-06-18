#! /usr/bin/bash

FFLAGS="-std=legacy" ./configure --prefix=$PREFIX
make -j$(nproc)
make install

git clone https://gitlab.com/hepcedar/lhapdf
find lhapdf/migration -type f -exec sed -i 's/(__doc__)\()/g' {} +
mv lhapdf/migration/* $PREFIX/bin
