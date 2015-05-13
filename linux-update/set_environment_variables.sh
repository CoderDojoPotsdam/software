#!/bin/sh

UPDATE_USERNAME=`ls /home | head -1`
UPDATE_HOME=/home/$UPDATE_USERNAME/
UPDATE_DIR=$UPDATE_HOME/software/linux-update/
UPDATE_STATUS=$UPDATE_DIR/status.log


export UPDATE_USERNAME
export UPDATE_HOME
export UPDATE_DIR
export UPDATE_STATUS
