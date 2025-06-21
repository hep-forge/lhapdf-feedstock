#! /usr/bin/bash

mkdir build-scripts
cd build-scripts

cmake $RECIPE_DIR/scripts
cd ..

echo "CHECKPOINT 1"
if [ command -v python >/dev/null 2>&1 ]; then
   echo "CHECKPOINT 2"
   PYTHONVERSION=$(python -c 'import sys; print("{}.{}".format(sys.version_info[0], sys.version_info[1]))')
   if [ "$(python -c 'import sys; sys.stdout.write(str(sys.version_info[0]))')" -eq 2 ]; then
echo "CHECKPOINT 3: $PYTHONVERSION"
        export PYTHONPATH=$PWD/../_build_env/lib/python$PYTHONVERSION:$PYTHONPATH
   fi
fi

echo "CHECKPOINT 4: $PYTHONVERSION"
autoreconf --force --install
./configure --prefix=$PREFIX FCFLAGS="-O2 -std=legacy" CFLAGS="-O2"

make -j$(nproc)
make install

ln -s $PREFIX/lib/libLHAPDF.so $PREFIX/lib/libLHAPDF.dylib

# check python2.x is used — if so, install the migration scripts
echo "CHECKPOINT 5"
if [ ! -z "$PYTHONVERSION" ]; then

echo "CHECKPOINT 6"
  mv pyext/build/lib.linux-x86_64-$PYTHONVERSION $PREFIX/lib/python$PYTHONVERSION/site-packages/lhapdf5
  export PYTHONPATH=$PREFIX/lib/python$PYTHONVERSION/site-packages/lhapdf5:$PYTHONPATH

echo "CHECKPOINT 7"
  git clone https://gitlab.com/hepcedar/lhapdf
  cp -R lhapdf/migration $PREFIX/share/lhapdf
  find lhapdf/migration -type f \
       -exec sed -i 's/usage=\(__doc__\)//g' {} +
echo "CHECKPOINT 8"
  cp lhapdf/migration/cmpplotv5v6 $PREFIX/bin
  cp lhapdf/migration/creategrids  $PREFIX/bin
  cp lhapdf/migration/lhapdf5to6   $PREFIX/bin
  cp lhapdf/migration/tomigrate    $PREFIX/bin
  cp lhapdf/migration/cmpv5v6      $PREFIX/bin
  cp lhapdf/migration/plotv5v6     $PREFIX/bin
fi
