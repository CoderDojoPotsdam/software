#!/bin/sh

echo -----------------------------------------------------------------
date
git rev-list --parents HEAD
echo

# install git

apt-get -y install git

# update the repository

cd ~

# test if directory exists
# http://www.cyberciti.biz/tips/find-out-if-directory-exists.html
if [ -d software ]
then
  cd software/
  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git pull'
  
else 
  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git clone git@github.com:CoderDojoPotsdam/software.git'
  cd software/
fi

cd linux-update

rm /etc/rc.local
ln -s `pwd`/coder-dojo-potsdam-update-service.sh /etc/rc.local
