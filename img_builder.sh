#!/bin/bash
set -e
#set -x

WORK_DIR="/tmp/corkscrew"
ISO_DIR="/vagrant/iso"
TMP_DIR="/vagrant/tmp"
PROFILES_DIR="/vagrant/profiles"

mkdir -p $WORK_DIR
mkdir -p $ISO_DIR
mkdir -p $TMP_DIR

# update profiles
rsync -av $PROFILES_DIR $WORK_DIR

#export http_proxy=http://192.168.33.254:3142
build-simple-cdd  --conf /vagrant/simple-cdd.conf $@
#build-simple-cdd  --conf /vagrant/simple-cdd.conf --debian-mirror http://192.168.33.254:3142/debian
#build-simple-cdd  --conf /vagrant/simple-cdd.conf --debian-mirror http://localhost:9999/debian | tee /vagrant/tmp/build-simple-cdd.log

# backup mirror
rsync -av --delete $WORK_DIR/tmp/mirror $TMP_DIR

find $WORK_DIR -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs isohybrid