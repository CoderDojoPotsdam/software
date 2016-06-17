#!/bin/sh

# we assume super user previleges

for package in $(grep -vE "^\s*#" ${UPDATE_DIR}packages_to_install.txt  | tr "\n" " ")
do
  # http://askubuntu.com/questions/252734/apt-get-mass-install-packages-from-a-file#252735
  apt-get -y -q install $package
done

apt-get -y -f install
