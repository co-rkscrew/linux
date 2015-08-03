#!/bin/bash
set -e
#set -x

PKG_DIR="/vagrant/packages"
DEB_DIR="/vagrant/deb"

mkdir -p $DEB_DIR

function set_script_perms {
	find "$PKG_DIR" -type f -name "$1" | xargs -I {} chmod 775 {}
}

set_script_perms "preinst"
set_script_perms "postinst"
set_script_perms "prerm"
set_script_perms "postrm"

# each package subfolder represent a deb package to be build
find "$PKG_DIR" -maxdepth 1 ! -path "$PKG_DIR" -type d | sort | while read line; do
		dpkg-deb --build $line $DEB_DIR
done