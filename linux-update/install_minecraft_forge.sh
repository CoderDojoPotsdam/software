#!/bin/bash

source ./coder-dojo-profile-script.sh

# set the variables we need
if [ "$USER" == "$UPDATE_USERNAME" ] || [ -z "$UPDATE_USERNAME" ]
then
  echo running as current user
  UPDATE_USER_DESKTOP_PATH=`xdg-user-dir DESKTOP`
else
  echo running as root
  UPDATE_USER_DESKTOP_PATH=`su $UPDATE_USERNAME -c 'echo $(xdg-user-dir DESKTOP)'`
fi
FORGE_DIR=$UPDATE_USER_DESKTOP_PATH/minecraft-forge
VERSION=1.8.11
FORGE_ZIP=/tmp/mincraft-forge.zip
FORGE_URL=http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.8-11.14.3.1450/forge-1.8-11.14.3.1450-src.zip

# check if we already completed the setup
if [ -d $FORGE_DIR ] && [ "`cat $FORGE_DIR/VERSION`" == "$VERSION" ]
then
  echo "Minecraft Forge already installed at \"$FORGE_DIR\"."
  exit 0
else
  echo installing Minecraft Forge
  echo deleting $FORGE_DIR
  rm -rf $FORGE_DIR
  echo deleting $UPDATE_USER_DESKTOP_PATH/../.gradle
  rm -rf $UPDATE_USER_DESKTOP_PATH/../.gradle
fi

if [ -z "$JAVA_HOME" ] || [ ! -d $JAVA_HOME ]
then
  echo "ERROR: \$JAVA_HOME=$JAVA_HOME not set to existing directory, exiting."
  exit 1
fi

# download the forge zip
wget --quiet -O $FORGE_ZIP $FORGE_URL || { echo "Could not download $FORGE_URL" ; exit 2 ; }

mkdir -p $FORGE_DIR

unzip -o -qq $FORGE_ZIP -d $FORGE_DIR

( cd $FORGE_DIR ; ./gradlew setupDecompWorkspace --refresh-dependencies ; ) || { echo "ERROR: 1 gradle error $?" ; exit 3 ; }


# ( cd $FORGE_DIR ; ./gradlew idea ; ) || { echo "ERROR: 2.1 gradle error $?" ; exit 4 ; }
( cd $FORGE_DIR ; ./gradlew eclipse ; ) || { echo "ERROR: 2.2 gradle error $?" ; exit 5 ; }

chown -R "$UPDATE_USERNAME" $FORGE_DIR
echo $VERSION > $FORGE_DIR/VERSION
echo "installed minecraft forge"




