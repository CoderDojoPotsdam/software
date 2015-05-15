#!/bin/sh

cd $UPDATE_DIR
echo -----------------------------------------------------------------
date
git log --pretty=oneline -1
echo

# we can assume an internet connection
# we run as super user

# assuming that the user name is the first in the home directory
# create and update git repositories
echo ----- update repositories -----
echo -n "updating repositories... " >> $UPDATE_STATUS
if [ -d $UPDATE_HOME ]
then
  cd $UPDATE_HOME
  # update the organize repository
  $UPDATE_DIR/update_git_repository.sh git@github.com:CoderDojoPotsdam/organize.git organize
  # update the projects repository
  $UPDATE_DIR/update_git_repository.sh git@github.com:CoderDojoPotsdam/projects.git projects
  if [ -d projects ]
  then
    # link arduino files onto projects
    if [ ! -L $UPDATE_HOME/sketchbook]
    then
      mv -f $UPDATE_HOME/sketchbook/* $UPDATE_HOME/projects/Arduino
      rm -r $UPDATE_HOME/sketchbook/
    else 
      rm $UPDATE_HOME/sketchbook
    fi
    ln -s $UPDATE_HOME/projects/arduino $UPDATE_HOME/sketchbook
    # link scratch into projects
    for folder in { $UPDATE_HOME/* }
    do
      if [ "`realpath $folder`" != "`realpath $UPDATE_HOME/projects`" ]
      then
        if [ -d $folder/"Scratch Projects" ]
        then
          if [ ! -L $folder/"Scratch Projects" ]
          then
            mv -f $folder/"Scratch Projects"/* $UPDATE_HOME/projects/"Scratch Projects"
            rm -r $folder/"Scratch Projects"/
          fi
          ln -s $UPDATE_HOME/projects/"Scratch Projects" $folder/"Scratch Projects"
        fi
      fi
    done
    # automatically commit and push files of the coders
    cd projects
    git add .
    git commit -am"auto commit on $UPDATE_USERNAME@`hostname`" &&  ssh-agent bash -c 'ssh-add /home/*/.ssh/id_rsa; git push'
    cd ..
    chown -R $UPDATE_USERNAME projects
  fi
  echo done >> $UPDATE_STATUS

else
  echo failed >> $UPDATE_STATUS
fi


# install the software packages
cd $UPDATE_DIR
echo ----- install software -----
echo -n "installing software... " >> $UPDATE_STATUS

./install_software.sh

echo done >> $UPDATE_STATUS
# -----------------------------------------------------
# everything additional should go here
# -----------------------------------------------------
cd $UPDATE_DIR
echo ----- additional configuration -----
echo -n "additional configuration... " >> $UPDATE_STATUS

./set_startup_homepage.sh https://zen.coderdojo.com/dojo/861

./install_app_inventor.sh
./install_opera.sh
./install_google_chrome.sh



echo done >> $UPDATE_STATUS
# -----------------------------------------------------
# update the system
cd $UPDATE_DIR
echo ----- update the system -----
echo -n "updating the system... " >> $UPDATE_STATUS
# http://stackoverflow.com/questions/3316677/apt-get-update-dist-upgrade-autoremove-autoclean-in-a-single-sudo-command
apt-get -y -qq update
apt-get -y -qq dist-upgrade
apt-get -y -qq autoremove
apt-get -y -qq autoclean

echo done >> $UPDATE_STATUS

# install the software packages again
cd $UPDATE_DIR
echo ----- install software again -----
echo -n "installing software again... " >> $UPDATE_STATUS

./install_software.sh

echo done >> $UPDATE_STATUS



