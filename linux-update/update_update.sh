#!/bin/sh

echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# install git

apt-get -y install git

# add github to the known hosts
# http://stackoverflow.com/questions/13363553/git-error-host-key-verification-failed-when-connecting-to-remote-repository
ssh-keygen -R domain.com
# http://serverfault.com/questions/132970/can-i-automatically-add-a-new-host-to-known-hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# update the repository

cd /home/coderdojo

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

chown -R coderdojo .

cd linux-update

rm /etc/rc.local
ln -s `pwd`/coder-dojo-potsdam-update-service.sh /etc/rc.local
