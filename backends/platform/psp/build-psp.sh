#!/bin/bash

## Make sure PSPDEV is set
if [ -z "${PSPDEV}" ]; then
    echo "The PSPDEV environment variable has not been set"
    exit 1
fi

CXXFLAGS="-isystem ${PSPDEV}/psp/include"
export CXXFLAGS
make distclean
./configure --host=psp --disable-debug --enable-plugins --default-dynamic --enable-release
make -j4
export VERSION="$(make print-distversion)"
export DISTS="$(make print-dists)"
mkdir scummvm-$VERSION
cp -r $DISTS EBOOT.PBP plugins scummvm-$VERSION
mkdir scummvm-$VERSION/kbd
cp -r backends/platform/psp/kbd/*.png scummvm-$VERSION/kbd
zip -r9 scummvm-$VERSION-psp.zip scummvm-$VERSION

