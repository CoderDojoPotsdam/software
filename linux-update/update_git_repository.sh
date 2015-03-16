#!/bin/sh

git_url=$1
folder_name=$2

cd $UPDATE_HOME

echo ----- $folder_name -----
# update the repository
if [ -d $folder_name ]
then
  cd $folder_name
  ssh-agent bash -c "ssh-add $UPDATE_HOME/.ssh/id_rsa; git pull"
  cd ..
else
  ssh-agent bash -c "ssh-add $UPDATE_HOME/.ssh/id_rsa; git clone ${git_url}"
fi 

# configure the repository
if [ -d $folder_name ]
then
  cd $folder_name
  git config --local user.email "coderdojopotsdam-discuss@googlegroups.com"
  git config --local user.name "Coder Dojo Potsdam - $UPDATE_USERNAME@`hostname`"
  git config --local push.default simple
  cd ..

  chown -R $UPDATE_USERNAME $folder_name
else
  echo Error: Git repository $folder_name not found.
fi


