#!/bin/bash

USER=vagrant
HOMEDIR=/home/$USER
LXDE_CONF=/etc/lxdm/default.conf
PROJECTDIR=/vagrant

source_dir="$PROJECTDIR/files"

[ -d "$source_dir" ]

# Something funky with the default d/l URL - this mirror seems to work
ALPINEREPO=http://dl-5.alpinelinux.org/alpine/v3.2/main

apk -X $ALPINEREPO --update add openjdk7-jre
apk -X $ALPINEREPO add firefox
apk -X $ALPINEREPO add twm
apk -X $ALPINEREPO add libxmu6 || true
apk -X $ALPINEREPO add icedtea-7-plugin
apk -X $ALPINEREPO add rsync

#sudo apt-get install -y firefox
#sudo apt-get install -y openjdk-7-jre
#sudo apt-get install -y libxmu6
#sudo apt-get install -y icedtea-7-plugin 

#sudo apt-get install -y lxde --fix-broken
# These dependencies always fail installation and the error sticks around - I don't think we need them
#sudo apt-get remove -y dictionaries-common miscfiles

# Copy files into home dir
echo "Running: rsync -a $source_dir/ $HOMEDIR/"
ls -aF "$source_dir"
rsync -a "$source_dir/" "$HOMEDIR/"
chown -R $USER:$USER $HOMEDIR

# Remove some unnecessary packages, clear apt caches and clean up
# (Although none of this actually reduces disk file size since we're not
# zeroing the data on the disk and reducing the image size accordingly)
#apt-get remove -y lxmusic juju --auto-remove
#apt-get autoremove
#apt-get autoclean
#apt-get clean
#rm -rf /tmp/* /var/{cache,tmp}/* /var/lib/apt/lists/*

# Firefox plugin configuration
#sudo update-alternatives --set mozilla-javaplugin.so /usr/lib/jvm/java-7-openjdk-i386/jre/lib/i386/IcedTeaPlugin.so

# Skip login screen altogether, and get rid of unused user
echo -e "[base]\nautologin=$USER" >> /etc/lxdm/default.conf
deluser ubuntu

