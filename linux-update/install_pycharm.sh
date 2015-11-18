#!/bin/bash

# all variables we need to configure the script
pycharm_archive_url=https://download.jetbrains.com/python/pycharm-community-5.0.1.tar.gz
pycharm_temp_folder=/tmp/pycharm
pycharm_archive=/tmp/pycharm-community-4.5.3.tar.gz
pycharm_folder=/opt/pycharm
pycharm_version=5.0.1
pycharm_version_file=$pycharm_folder/VERSION

if ! type realpath
then
  echo install realpath with \"sudo apt-get install realpath\"!
fi

if [ -d "$pycharm_folder" ] && [ -f "$pycharm_version_file" ] && [ "`cat \"$pycharm_version_file\"`" == "$pycharm_version" ]
then
  echo "Pycharm already installed."
  exit 0
fi

echo create the folder $pycharm_temp_folder
rm -rf $pycharm_temp_folder
mkdir -p $pycharm_temp_folder

echo download pycharm
wget -q -O "$pycharm_archive" "$pycharm_archive_url" || { 
  echo "downloading PyCharm failed." ; 
  exit 1; 
}

# could add owner to tar
# --owner "$UPDATE_USERNAME"

echo unpack pycharm
( cd "$pycharm_temp_folder" && tar -zxf "$pycharm_archive" ; ) || {
  echo "Error unpacking PyCharm";
  exit 2;
}

echo remove the archive so only one folder is left in $pycharm_temp_folder
rm "$pycharm_archive"

echo install icon
cp ./jetbrains-pycharm-ce.desktop /usr/share/applications

echo link the pycharm projects into projects
for user_home in /home/*
do
  rm $user_home/PycharmProjects
  ln -s `realpath $UPDATE_HOME/projects/Python` $user_home/PycharmProjects
done

echo move everything to $pycharm_folder
rm -rf "$pycharm_folder"
mv "$pycharm_temp_folder"/* "$pycharm_folder"

# set the version
echo -n $pycharm_version > $pycharm_version_file


