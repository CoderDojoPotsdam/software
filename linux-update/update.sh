#!/bin/sh

echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# we can assume an internet connection
# we run as super user

# assuming that the user name is coderdojo
# create and update git repositories
if [ -d /home/coderdojo ]
then
  cd /home/coderdojo
  # update the organize repository
  /home/coderdojo/software/linux-update/update_git_repository.sh git@github.com:CoderDojoPotsdam/organize.git organize
  # update the projects repository
  /home/coderdojo/software/linux-update/update_git_repository.sh git@github.com:CoderDojoPotsdam/projects.git projects
  if [ -d projects ]
  then
    cd projects
    git commit -am"auto commit on `hostname`" &&  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git push'
    cd ..
    chown -R coderdojo projects
  fi
fi

# install the software packages
echo ----- install software -----
cd /home/coderdojo/software/linux-update
./install_software.sh

# update the system
echo ----- update the system -----
# http://stackoverflow.com/questions/3316677/apt-get-update-dist-upgrade-autoremove-autoclean-in-a-single-sudo-command
apt-get -y -qq update
apt-get -y -qq dist-upgrade
apt-get -y -qq autoremove
apt-get -y -qq autoclean

# install the software packages again
echo ----- install software again -----
cd /home/coderdojo/software/linux-update
./install_software.sh




