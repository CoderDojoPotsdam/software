#!/bin/bash

# all variables we need to configure the script
pycharm_archive_url=http://download-cf.jetbrains.com/python/pycharm-community-4.5.3.tar.gz
pycharm_temp_folder=/tmp/pycharm
pycharm_archive=/tmp/pycharm-community-4.5.3.tar.gz
pycharm_folder=/opt/pycharm

if [ -d $pycharm_folder ]
then
  echo "Pycharm already installed."
  exit 0
fi

echo create the folder $pycharm_temp_folder
rm -rf $pycharm_temp_folder
mkdir -p $pycharm_temp_folder

echo download pycharm
wget -q -O "$pycharm_archive" "$pycharm_archive_url"

# could add owner to tar
# --owner "$UPDATE_USERNAME"

echo unpack pycharm
( cd "$pycharm_temp_folder" ; tar -zxf "$pycharm_archive" ; )

echo remove the archive so only one folder is left in $pycharm_temp_folder
rm "$pycharm_archive"

echo install icon
cp ./jetbrains-pycharm-ce.desktop /usr/share/applications

echo link the pycharm projects into projects
for user_home in /home/*
do
  ln -s `realpath $UPDATE_HOME/projects/Python` $user_home/PycharmProjects
done

echo move everything to $pycharm_folder
rm -rf "$pycharm_folder"
mv "$pycharm_temp_folder"/* "$pycharm_folder"

