#!/bin/bash
# install libcurl
set -e

ROOTDIR=${ZZROOT:-$HOME/app}
NAME="libcurl"
TYPE=".tar.gz"
FILE="$NAME$TYPE"
DOWNLOADURL="https://curl.haxx.se/download/curl-7.67.0.tar.gz"
echo $NAME will be installed in $ROOTDIR
echo Dependency: autoconf, automake, libtool, m4, nroff, perl, openssl

mkdir -p $ROOTDIR/downloads
cd $ROOTDIR

if [ -f "downloads/$FILE" ]; then
    echo "downloads/$FILE exist"
else
    echo "$FILE does not exist, downloading from $DOWNLOADURL"
    wget $DOWNLOADURL -O $FILE
    mv $FILE downloads/
fi

mkdir -p src/$NAME
tar xf downloads/$FILE -C src/$NAME --strip-components 1

cd src/$NAME

./buildconf
./configure --with-ssl --prefix=$ROOTDIR --with-ssl=$ROOTDIR/ssl
make -j && make install

echo $NAME installed on $ROOTDIR
