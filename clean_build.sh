#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

rm -rf $DIR/{deb,iso,tmp}
cd $DIR
vagrant destroy -f
vagrant up
vagrant ssh -c '/vagrant/img_builder.sh'