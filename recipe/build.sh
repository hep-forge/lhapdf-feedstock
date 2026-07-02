#! /usr/bin/bash
set -e

mkdir build-scripts
cd build-scripts

cmake $RECIPE_DIR/scripts
cd ..

# Bundled config.sub/config.guess predate aarch64 triplets -- replace with
# the current ones from the gnuconfig package before configuring.
for f in config.sub config.guess; do
  find . -name "$f" -exec cp "$BUILD_PREFIX/share/gnuconfig/$f" {} \;
done

./configure --prefix=$PREFIX FCFLAGS="-O2 -std=legacy" CFLAGS="-O2"

make -j$(nproc)
make install
