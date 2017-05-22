#!/bin/bash

echo "[software] ---------------------------------"
echo "[software] install NodeJS (v6.10.3)"
echo "[software] ---------------------------------"

echo "[software] download..."
wget https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-armv7l.tar.xz
echo "[software] decompress..."
tar xf node-v6.10.3-linux-armv7l.tar.xz

# move directory to /usr/lib/node

echo "[software] move to /usr/lib/node"
mkdir -p /usr/lib/node/
mv node-v6.10.3-linux-armv7l /usr/lib/node/v6.10.3

# create links in /usr/bin
echo "[software] create symlinks"
ln -s /usr/lib/node/v6.10.3/bin/node /usr/bin/node
ln -s /usr/lib/node/v6.10.3/bin/npm /usr/bin/npm

echo "[software] clean"
rm -Rf node-v6.10.3-linux-armv7l.tar.xz

echo "[software] ---------------------------------"
echo "[software] install xvfb"
echo "[software] ---------------------------------"

# apt-get install -y libgtk2.0-dev
apt-get install -y libgtk2.0-0
apt-get install -y libxtst6
apt-get install -y xvfb x11-xkb-utils
apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic


echo "[software] ---------------------------------"
echo "[software] install electron (v1.6.6)"
echo "[software] ---------------------------------"

echo "[software] install electron deps"

apt-get install -y libxss1
apt-get install -y GConf2
apt-get install -y libnss3-dev

echo "[software] download..."

wget https://github.com/electron/electron/releases/download/v1.6.6/electron-v1.6.6-linux-armv7l.zip
unzip electron-v1.6.6-linux-armv7l.zip -d v1.6.6

echo "[software] move to /usr/lib/electron"
mkdir -p /usr/lib/electron/
mv v1.6.6 /usr/lib/electron

echo "[software] create symlink"
ln -s /usr/lib/electron/v1.6.6/electron /usr/bin/electron

echo "[software] clean"
rm -Rf electron-v1.6.6-linux-armv7l.zip
