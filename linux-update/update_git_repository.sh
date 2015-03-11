#!/bin/sh

git_url=$1
folder_name=$2

cd /home/coderdojo

echo ----- $folder_name -----
if [ -d $folder_name ]
then
  cd $folder_name
  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git pull'
  cd ..
else
  ssh-agent bash -c 'ssh-add /home/coderdojo/.ssh/id_rsa; git clone $git_url'
fi 

# configure repository
cd $folder_name
git config --local user.email "coderdojopotsdam-discuss@googlegroups.com"
git config --local user.name "Coder Dojo Potsdam - `hostname`"
git config --local push.default simple
cd ..

chown -R coderdojo $folder_name



