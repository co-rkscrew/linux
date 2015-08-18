#!/bin/bash
set -e
# load vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/vars

$DIR/nginx-deb-cacher/setup.sh $DIR/vars
VAGRANT_CWD=$DIR/nginx-deb-cacher vagrant $@