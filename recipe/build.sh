#! /usr/bin/bash

FFLAGS="-std=legacy" ./configure --prefix=$PREFIX
make -j$(nproc)
make install

git clone https://gitlab.com/hepcedar/lhapdf
mv lhapdf/migration $PREFIX/share/lhapdf
find $PREFIX/share/lhapdf -type f -exec sed -i 's/(__doc__)\()/g' {} +
