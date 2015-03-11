#!/bin/sh

# we run as super user

cd /home/coderdojo/software/linux-update

./update_update.sh >>update_update.sh.log 2>>update_update.sh.log

./update.sh >>update.sh.log 2>>update.sh.log


