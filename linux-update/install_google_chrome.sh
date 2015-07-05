#!/bin/sh


if type google-chrome >>/dev/null 2>>/dev/null
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

  wget --quiet https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb \
  || { echo "failed to download google chrome" ; exit 1; }

  cd /

  echo installing from /tmp/google_chrome_setup/*

  dpkg --install /tmp/google_chrome_setup/*
  # from http://www.thinkplexx.com/learn/snippet/shell/advanced/automatically-install-dependencies-with-dpkg-i
  if [ $? -gt 0 ]
  then
    apt-get -f --force-yes --yes install>/dev/null 2>&1
    dpkg --install /tmp/google_chrome_setup/*
  fi

  rm -r /tmp/google_chrome_setup/

fi
