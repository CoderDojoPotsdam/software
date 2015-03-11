#!/bin/sh

# we assume super user previleges

# http://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file#252735
apt-get -y -q install $(grep -vE "^\s*#" packages_to_install.txt  | tr "\n" " ")

