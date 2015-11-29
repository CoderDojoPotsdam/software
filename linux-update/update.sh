#!/bin/bash

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
    if [ ! -L $UPDATE_HOME/sketchbook ]
    then
      mv -f $UPDATE_HOME/sketchbook/* $UPDATE_HOME/projects/Arduino
      rm -r $UPDATE_HOME/sketchbook/
    else 
      rm $UPDATE_HOME/sketchbook
    fi
    ln -s $UPDATE_HOME/projects/Arduino $UPDATE_HOME/sketchbook
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
          else
            rm $folder/"Scratch Projects"
          fi
          ln -s $UPDATE_HOME/projects/"Scratch Projects" $folder/"Scratch Projects"
        fi
      fi
    done
    echo automatically commit and push files of the coders
    cd projects
    git add --all .
    git commit -am"Autocommit on $UPDATE_USERNAME@`hostname`" &&  ssh-agent bash -c "ssh-add $UPDATE_HOME/.ssh/id_rsa; git push"
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

./set_startup_homepage.sh https://CoderDojoPotsdam.github.io

./install_app_inventor.sh
./install_opera.sh
./install_google_chrome.sh

# copy new IDLE launchers
  # remove old launchers
rm -f /usr/share/applications/idle-python3.*.desktop
rm -f /usr/share/applications/idle-python2.*.desktop
  # copy logos
cp /usr/share/pixmaps/python3.*.xpm /usr/share/pixmaps/python3.xpm
cp /usr/share/pixmaps/python2.*.xpm /usr/share/pixmaps/python2.xpm
  # copy launchers
cp ./idle-python3.desktop /usr/share/applications/
cp ./idle-python2.desktop /usr/share/applications/

# copy moon-buggy
cp ./moon-buggy.desktop /usr/share/applications/

# copy Scratch 2 installer files
if [ ! -f '/opt'/'Scratch 2'/bin/'Scratch 2' ]
then
  cp ./scratch-2-installer.desktop /usr/share/applications/
  cp ./install_scratch_2.sh /opt/
fi

# create projects link on desktop
# getting the windows directory http://stackoverflow.com/a/4361421/1320237
# runnning as a different user http://www.cyberciti.biz/open-source/command-line-hacks/linux-run-command-as-different-user/
UPDATE_USER_DESKTOP_PATH=`su $UPDATE_USERNAME -c 'echo $(xdg-user-dir DESKTOP)'`
rm -f                       $UPDATE_USER_DESKTOP_PATH/'Alles hier speichern.'
ln -s $UPDATE_HOME/projects $UPDATE_USER_DESKTOP_PATH/'Alles hier speichern.'

# add environment scripts to profile directory
#   https://help.ubuntu.com/community/EnvironmentVariables
cp ./coder-dojo-profile-script.sh /etc/profile.d

# install Minecraft Forge
su $UPDATE_USERNAME -c './install_minecraft_forge.sh'

./install_pycharm.sh
./install_hamstermodell.sh

echo done >> $UPDATE_STATUS
# -----------------------------------------------------
# update the system
# -----------------------------------------------------
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



