#!/bin/bash
set -e
#set -x

WORK_DIR="/tmp/corkscrew"
ISO_DIR="/vagrant/iso"

mkdir -p $WORK_DIR && cd $_
mkdir -p $ISO_DIR

build-simple-cdd  --conf /vagrant/simple-cdd.conf
#build-simple-cdd  --conf /vagrant/simple-cdd.conf --debian-mirror http://localhost:9999/debian

find $WORK_DIR -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs isohybrid