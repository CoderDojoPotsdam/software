#!/bin/sh

cd /home/coderdojo/software/linux-update

sudo ln -s --backup `pwd`/coder-dojo-potsdam-update-service.sh /etc/rc.local

# show or generate ssh key
if [ -f ~/.ssh/id_rsa ]
then
  echo < ~/.ssh/id_rsa.pub
  # pipe stderr
  # http://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdouthttp://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
  # test it text is present
  # http://stackoverflow.com/questions/12375722/how-do-i-test-in-one-line-if-command-output-contains-a-certain-string
  if ( ssh -T git@github.com 2>&1 >/dev/null | grep -q "You've successfully authenticated" )
  then 
    echo OK. Everything is fine. Can authenticate at github.com
  else 
    ssh-keygen -y -f ~/.ssh/id_rsa
    ssh -T git@github.com
    echo 
    echo add the public key to your github account https://github.com/settings/ssh
  fi
else
  # generate ssh key
  # https://help.github.com/articles/generating-ssh-keys/
  ssh-keygen -t rsa -C "coderdojopotsdam-discuss@googlegroups.com" -f ~/.ssh/id_rsa -N ""
  ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
  ssh-keygen -y -f ~/.ssh/id_rsa
  echo 
  echo add the public key to your github account https://github.com/settings/ssh
fi

git config --global user.email "coderdojopotsdam-discuss@googlegroups.com"
git config --global user.name "Coder Dojo Potsdam - `hostname`"
