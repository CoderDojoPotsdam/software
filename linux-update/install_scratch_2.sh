#/bin/sh

echo run with sudo 

# http://askubuntu.com/a/440540
apt-get -y install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 libnss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386
apt-get -y install libgnome-keyring0:i386

cd /tmp

# download adobe air
#if [ ! -f adobeair_2.6.0.19170-devolo1_i386.deb ]
#then
  rm adobeair_2.6.0.19170-devolo1_i386.deb
  wget --quiet http://update.devolo.com/linux/apt/pool/main/a/adobeair/adobeair_2.6.0.19170-devolo1_i386.deb
#fi

# install adobe air
# http://askubuntu.com/a/441067
# http://askubuntu.com/questions/40779/how-do-i-install-a-deb-file-via-the-command-line
sudo dpkg -i adobeair_2.6.0.19170-devolo1_i386.deb 

sudo apt-get -f -y install

sudo dpkg -i adobeair_2.6.0.19170-devolo1_i386.deb 

# http://stackoverflow.com/questions/19261098/how-to-run-execute-an-adobe-air-file-on-linux-ec2-ubuntu-from-command-line-onl
rm /usr/sbin/airinstall
ln -s "/opt/Adobe AIR/Versions/1.0/Adobe AIR Application Installer" /usr/sbin/airinstall

# download Scratch 2
#if [ ! -f Scratch-*.air ]
#then 
  echo Downloading Scratch 2 ... this may take a while.
  rm Scratch-436.air
  wget --quiet https://scratch.mit.edu/scratchr2/static/sa/Scratch-436.air
#fi

echo installing scratch

airinstall `pwd`/Scratch-*.air


