#!/bin/sh

# following the tutorial at
# http://appinventor.mit.edu/explore/ai2/linux.html

# to uninstall do 
# sudo rm -rf /usr/google/appinventor
# sudo rm -rf ~/.appinventor

# check fr app invntor is installed
if [ -d /usr/google/appinventor ]
then
  echo app inventor is already installed
else
  echo intalling app inventor
  # download the app inventor package
  if [ -d /tmp/app_inventor_setup ]
  then
    rm -r /tmp/app_inventor_setup
  fi
  mkdir /tmp/app_inventor_setup

  cd /tmp/app_inventor_setup

  wget --quiet http://commondatastorage.googleapis.com/appinventordownloads/appinventor2-setup_1.1_all.deb

  echo installing from /tmp/app_inventor_setup/*
  dpkg --install /tmp/app_inventor_setup/*
  
  cd /

  rm -r /tmp/app_inventor_setup
fi

echo starting app inventor aiStarter. see aiStarter.log

'/usr/google/appinventor/commands-for-Appinventor/aiStarter' 2>> $UPDATE_DIR/aiStarter.log >> $UPDATE_DIR/aiStarter.log &

