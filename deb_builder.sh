#!/bin/bash
set -e
#set -x

# load vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/vars

mkdir -p $DEB_DIR

# each package subfolder represent a deb package to be build
find "$PKG_DIR" -maxdepth 1 ! -path "$PKG_DIR" -type d | sort | while read line; do
		
		echo $line
		cd $line
		dpkg-buildpackage -us -uc
done

find "$PKG_DIR" -maxdepth 1 -type f | xargs -I {} mv {} $DEB_DIR

if [[ $* == *--lintian* ]]; then
	LOG="$TMP_DIR/lintian.log"
	rm -f $LOG
	find "$DEB_DIR" -type f -name "*.changes" | sort | while read line; do
		lintian -i -I --show-overrides $line | tee -a $LOG
	done
	echo "wrote log file: $LOG"
fi