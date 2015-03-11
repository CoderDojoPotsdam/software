#!/bin/sh

cd /home/coderdojo/software/linux-update

#configure autostart
sudo ln -s --backup `pwd`/coder-dojo-potsdam-update-service.sh /etc/rc.local

# configure global settings
git config --global user.email "coderdojopotsdam-discuss@googlegroups.com"
git config --global user.name "Coder Dojo Potsdam - `hostname`"
git config --global push.default simple

# configure repository
git config --local --unset remote.origin.url
git config --local remote.origin.url git@github.com:CoderDojoPotsdam/software.git

# create log files
touch update.sh.log
touch update_update.sh.log

# see if we have a private key
if [ -f ~/.ssh/id_rsa ]
then
  # there is a private key
  sleep 0
else
  # generate ssh key
  # https://help.github.com/articles/generating-ssh-keys/
  ssh-keygen -t rsa -C "coderdojopotsdam-discuss@googlegroups.com" -f ~/.ssh/id_rsa -N ""
fi

# see if we have a public key
if [ -f ~/.ssh/id_rsa.pub ]
then
  # there is a public key
  sleep 0
else
  # generate the public key
  ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
  
fi

# try to connect to github
can_connect_to_github=0
while [ $can_connect_to_github -ne 1 ]
do
  # pipe stderr
  # http://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdouthttp://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
  # test it text is present
  # http://stackoverflow.com/questions/12375722/how-do-i-test-in-one-line-if-command-output-contains-a-certain-string
  if ( ssh -T git@github.com 2>&1 >/dev/null | grep -q "You've successfully authenticated" )
  then 
    can_connect_to_github=1
    echo OK. Everything is fine. Can authenticate at github.com
  else 
    echo
    ssh-keygen -y -f ~/.ssh/id_rsa
    echo 
    echo add the public key to your github account https://github.com/settings/ssh and say yes
    echo
  fi
done
