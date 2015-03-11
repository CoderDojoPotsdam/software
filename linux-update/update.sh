#!/bin/sh

echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# we can assume an internet connection
# we run as super user

# configure global settings


# assuming that the user name is coderdojo
# create and update git repositories
if [ -d /home/coderdojo ]
then
  cd /home/coderdojo
  # update the organize repository
  ./update_git_repository.sh git@github.com:CoderDojoPotsdam/organize.git organize
  # update the projects repository
  ./update_git_repository.sh git@github.com:CoderDojoPotsdam/projects.git projects
  cd projects
  git commit -am"auto commit on `hostname`" &&  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git push'
  cd ..
  chown -R coderdojo projects
fi



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




