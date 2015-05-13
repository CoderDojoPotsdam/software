#!/bin/sh

dpkg --configure -a

# we run as super user

./set_environment_variables.sh

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
