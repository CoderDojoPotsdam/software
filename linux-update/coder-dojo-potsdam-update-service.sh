#!/bin/sh

dpkg --configure -a

# we run as super user
# set environment variables
UPDATE_USERNAME=`ls /home | head -1`
UPDATE_HOME=/home/$UPDATE_USERNAME/
UPDATE_DIR=$UPDATE_HOME/software/linux-update/
UPDATE_STATUS=$UPDATE_DIR/status.log

export UPDATE_USERNAME
export UPDATE_HOME
export UPDATE_DIR
export UPDATE_STATUS

if [ -f $UPDATE_DIR/rc.local ]
then
  $UPDATE_DIR/rc.local
fi

# create status log
if [ -f $UPDATE_STATUS ]
then
  rm $UPDATE_STATUS
fi
touch $UPDATE_STATUS

# update the system
$UPDATE_DIR/wait_for_internet_connection.sh

$UPDATE_DIR/update_update.sh >>"$UPDATE_DIR/update_update.sh.log" 2>>"$UPDATE_DIR/update_update.sh.log"

$UPDATE_DIR/update.sh >>"$UPDATE_DIR/update.sh.log" 2>>"$UPDATE_DIR/update.sh.log"

echo update complete  >> $UPDATE_STATUS
