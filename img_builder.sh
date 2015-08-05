#!/bin/bash
set -e
#set -x

STARTTIME=$(date +%s)

# load vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/vars

mkdir -p $WORK_DIR_SIMPLE_CDD
mkdir -p $ISO_DIR
mkdir -p $TMP_DIR

# build deb packages
/vagrant/deb_builder.sh

# update profiles
rsync -av --delete $PROFILES_DIR $WORK_DIR_SIMPLE_CDD

# restore mirror (if available)
if [ -d "$MIRROR_DIR" ]; then
	rsync -a --delete $MIRROR_DIR $WORK_DIR/tmp/
fi

# build corkscrew distribution
export WORK_DIR=$WORK_DIR
export SIMPLE_CDD_DEB_MIRROR=$SIMPLE_CDD_DEB_MIRROR
export SIMPLE_CDD_DEB_SMIRROR=$SIMPLE_CDD_DEB_SMIRROR
export DEB_DIR=$DEB_DIR
export ISO_DIR=$ISO_DIR

build-simple-cdd  --conf $SIMPLE_CDD_DIR/simple-cdd.conf $@ 2>&1 | tee $SIMPLE_CDD_LOG

# backup mirror
rsync -a --delete $WORK_DIR/tmp/mirror $TMP_DIR

# isohybrid makes iso bootable from usb
find $WORK_DIR -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs isohybrid

ENDTIME=$(date +%s)
ELAPSED="$(($ENDTIME - $STARTTIME))"
echo "Elapsed time:  $(date -d@$ELAPSED -u +%H:%M:%S)"
