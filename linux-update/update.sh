#!/bin/sh

echo -----------------------------------------------------------------
date
git rev-list --parents HEAD
echo

# we can assume an internet connection
# we run as super user

# update the system
echo ----- update the system -----
# http://stackoverflow.com/questions/3316677/apt-get-update-dist-upgrade-autoremove-autoclean-in-a-single-sudo-command
apt-get -y -qq update
apt-get -y -qq dist-upgrade
apt-get -y -qq autoremove
apt-get -y -qq autoclean

# install the software packages
echo ----- install software -----
./install_software.sh

# assuming that the user name is coderdojo
# create git repositories
if [ -d /home/coderdojo ]
then
  cd /home/coderdojo
  # update the organize repository
  echo ----- organize -----
  if [ -d organize ]
  then
    cd organize
    ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git pull --no-commit'
    cd ..
  else
    ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git clone git@github.com:CoderDojoPotsdam/organize.git'
  fi 
  # update the projects repository
  echo ----- projects -----
  if [ -d projects ]
  then
    cd projects
    ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git pull'
    cd ..
  else
    ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git clone git@github.com:CoderDojoPotsdam/projects.git'
  fi 
fi




