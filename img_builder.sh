#!/bin/bash
set -e
#set -x

# load vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/vars

mkdir -p $WORK_DIR
mkdir -p $ISO_DIR
mkdir -p $TMP_DIR

# build deb packages
#/vagrant/deb_builder.sh

# update profiles
rsync -av --delete $PROFILES_DIR $WORK_DIR

# restore mirror (if available)
if [ -d "$MIRROR_DIR" ]; then
	rsync -a --delete $MIRROR_DIR $WORK_DIR/tmp/
fi

build-simple-cdd  --conf $SIMPLE_CDD_DIR/simple-cdd.conf $@
#build-simple-cdd  --conf /vagrant/simple-cdd.conf --debian-mirror http://192.168.33.254:3142/debian
#build-simple-cdd  --conf /vagrant/simple-cdd.conf --debian-mirror http://localhost:9999/debian | tee /vagrant/tmp/build-simple-cdd.log

# backup mirror
rsync -a --delete $WORK_DIR/tmp/mirror $TMP_DIR

find $WORK_DIR -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs isohybrid