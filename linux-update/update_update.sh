#!/bin/sh

echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# install git
echo -n "installing git... " >> $UPDATE_STATUS

apt-get -y install git

# add github to the known hosts
# http://stackoverflow.com/questions/13363553/git-error-host-key-verification-failed-when-connecting-to-remote-repository
ssh-keygen -R domain.com
# http://serverfault.com/questions/132970/can-i-automatically-add-a-new-host-to-known-hosts
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
ssh-keyscan -H github.com >> /root/.ssh/known_hosts

echo done >> $UPDATE_STATUS

# update the repository

echo -n "updating the software repository... " >> $UPDATE_STATUS

cd $UPDATE_HOME

# test if directory exists
# http://www.cyberciti.biz/tips/find-out-if-directory-exists.html
if [ -d software ]
then
  cd $UPDATE_DIR
  ssh-agent bash -c "ssh-add $UPDATE_HOME/.ssh/id_rsa; git pull"
  
else 
  ssh-agent bash -c "ssh-add $UPDATE_HOME/.ssh/id_rsa; git clone git@github.com:CoderDojoPotsdam/software.git"
fi

chown -R $UPDATE_USERNAME $UPDATE_HOME/software


cd $UPDATE_DIR

rm /etc/rc.local
ln -s $UPDATE_DIR/coder-dojo-potsdam-update-service.sh /etc/rc.local

echo done >> $UPDATE_STATUS
