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
rsync -av $PROFILES_DIR $WORK_DIR/

# restore mirror
rsync -av --delete $TMP_DIR/mirror $WORK_DIR/tmp/

# rebuild without downloading mirror
build-simple-cdd  --conf /vagrant/simple-cdd.conf --no-do-mirror $@

# handle final images
find $WORK_DIR -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs isohybrid