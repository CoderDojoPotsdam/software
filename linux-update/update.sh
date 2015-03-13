#!/bin/sh

echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# we can assume an internet connection
# we run as super user

# assuming that the user name is coderdojo
# create and update git repositories
echo ----- update repositories -----
echo -n "updating repositories... " >> status.log
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
    git add .
    git commit -am"auto commit on `hostname`" &&  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git push'
    cd ..
    chown -R coderdojo projects
  fi
  echo failed >> status.log
else
  echo done >> status.log
fi


# install the software packages
echo ----- install software -----
echo -n "installing software... " >> status.log

cd /home/coderdojo/software/linux-update
./install_software.sh

echo done >> status.log
# -----------------------------------------------------
# everything additional should go here
# -----------------------------------------------------
cd /home/coderdojo/software/linux-update
echo ----- additional configuration -----
echo -n "additional configuration... " >> status.log

./set_startup_homepage.sh https://zen.coderdojo.com/dojo/861








echo done >> status.log
# -----------------------------------------------------
# update the system
echo ----- update the system -----
echo -n "updating the system... " >> status.log
# http://stackoverflow.com/questions/3316677/apt-get-update-dist-upgrade-autoremove-autoclean-in-a-single-sudo-command
apt-get -y -qq update
apt-get -y -qq dist-upgrade
apt-get -y -qq autoremove
apt-get -y -qq autoclean

echo done >> status.log

# install the software packages again
echo ----- install software again -----
echo -n "installing software again... " >> status.log

cd /home/coderdojo/software/linux-update
./install_software.sh

echo done >> status.log



