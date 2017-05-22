#!/bin/bash

echo "[install] update / ugrade"
apt-get update
apt-get -f updgrade
apt-get -f dist-updgrade

echo "[install] hardware utils"
apt-get install -y firmware-brcm80211 pi-bluetooth
# maybe iw is not needed
apt-get install -y wpasupplicant iw crda wireless-regdb wireless-tools
apt-get install -y wiringpi

echo "[install] software utils"
apt-get install -y sudo raspi-config
apt-get install -y nano xz-utils git unzip


echo "[install] expand file system to full SD card"
raspi-config --expand-rootfs

reboot now
