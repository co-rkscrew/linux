Corkscrew Linux
===============

!! under construction !!

Corkscrew Linux is a Debian based distribution. Mostly targeted to power users, it aims to be a stable, lightweight and versatile distribution.


Quickie (one-liner)
-------------------

How to download project and build a bootable image:

`git clone --recursive https://github.com/co-rkscrew/linux.git corkscrew-linux && cd corkscrew-linux && vagrant up && vagrant ssh -c '/vagrant/img_builder.sh'`

Already cloned? Just build a bootable image:

`vagrant up && vagrant ssh -c '/vagrant/img_builder.sh'`

Meanwhile grab a coffee and, if everything goes ok, an image should popup in /iso folder.

Features
--------

Under the hood:
- awesome window manager
- [awesome-copycats themes](https://github.com/copycat-killer/awesome-copycats))
- ...