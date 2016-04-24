#!/bin/bash
set -e

# load vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/vars

mkdir -p $WORK_DIR_SIMPLE_CDD $ISO_DIR $TMP_DIR ~/.gnupg

# build deb packages
/vagrant/deb_builder.sh

# update profiles
rsync -av --delete $PROFILES_DIR $WORK_DIR_SIMPLE_CDD

# delete self built packages so it can be added again
if [ -d "$WORK_DIR_SIMPLE_CDD/tmp/mirror" ]; then
	find "$PKG_DIR" -type f -name "control" -not -path "*/DEBIAN/*" | while read line; do
		package_name=`grep "Source:" $line | cut -c 9-`
		reprepro --basedir "$WORK_DIR_SIMPLE_CDD/tmp/mirror" remove $DIST $package_name
	done
fi

# build corkscrew distribution
export WORK_DIR_SIMPLE_CDD=$WORK_DIR_SIMPLE_CDD
export SIMPLE_CDD_DEB_MIRROR=$SIMPLE_CDD_DEB_MIRROR
export SIMPLE_CDD_DEB_SMIRROR=$SIMPLE_CDD_DEB_SMIRROR
export DEB_DIR=$DEB_DIR
export ISO_DIR=$ISO_DIR

build-simple-cdd --conf $SIMPLE_CDD_DIR/simple-cdd.conf --logfile $SIMPLE_CDD_LOG $@ 

# isohybrid makes iso bootable from usb
find $WORK_DIR_SIMPLE_CDD -type f -name "*.iso" | xargs -I {} mv {} $ISO_DIR
find $ISO_DIR -type f -name "*.iso" | xargs -I {} isohybrid --uefi {}
