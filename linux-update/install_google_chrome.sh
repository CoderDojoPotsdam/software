#!/bin/sh


if type opera >>/dev/null 2>>/dev/null
then
  echo google chrome is already installed
else

  echo installing google chrome

  if [ -d /tmp/google_chrome_setup ]
  then
    rm -r /tmp/google_chrome_setup
  fi

  mkdir /tmp/google_chrome_setup

  cd /tmp/google_chrome_setup 

  wget --quiet https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb

  cd /

  echo installing from /tmp/google_chrome_setup/*

  dpkg --install /tmp/google_chrome_setup/*

  rm -r /tmp/google_chrome_setup/

fi
