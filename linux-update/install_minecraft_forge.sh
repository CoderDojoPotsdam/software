#!/bin/bash

source ./coder-dojo-profile-script.sh

# set the variables we need
UPDATE_USER_DESKTOP_PATH=`su $UPDATE_USERNAME -c 'echo $(xdg-user-dir DESKTOP)'`
FORGE_DIR=$UPDATE_USER_DESKTOP_PATH/minecraft-forge-1.7.x
TEMP_FORGE_DIR=/tmp/forge
FORGE_ZIP=/tmp/mincraft-forge.zip
FORGE_URL=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.7.10-10.13.4.1448-1.7.10/forge-1.7.10-10.13.4.1448-1.7.10-src.zip

# check if we already completed the setup
if [ -d $FORGE_DIR ]
then
  echo "Minecraft Forge already installed at \"$FORGE_DIR\"."
  exit 0
else
  echo installing Minecraft Forge
fi

if [ -z "$JAVA_HOME" ] || [ ! -d $JAVA_HOME ]
then
  echo "ERROR: \$JAVA_HOME=$JAVA_HOME not set to existing directory, exiting."
  exit 1
fi

# download the forge zip
wget --quiet -O $FORGE_ZIP $FORGE_URL || { echo "Could not download $FORGE_URL" ; exit 2 ; }

mkdir -p $TEMP_FORGE_DIR

unzip -o -qq $FORGE_ZIP -d $TEMP_FORGE_DIR

( cd $TEMP_FORGE_DIR ; ./gradlew setupDecompWorkspace --refresh-dependencies ; ) || { echo "ERROR: 1 gradle error $?" ; exit 3 ; }


( cd $TEMP_FORGE_DIR ; ./gradlew idea ; ) || { echo "ERROR: 2.1 gradle error $?" ; exit 4 ; }
( cd $TEMP_FORGE_DIR ; ./gradlew eclipse ; ) || { echo "ERROR: 2.2 gradle error $?" ; exit 4 ; }

rm -rf $FORGE_DIR
echo deleted $FORGE_DIR, moving $TEMP_FORGE_DIR to $FORGE_DIR
mv $TEMP_FORGE_DIR $FORGE_DIR
chown -R "$UPDATE_USERNAME" $FORGE_DIR




