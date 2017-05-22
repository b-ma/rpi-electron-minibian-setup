#!/bin/bash

echo "[create-user] create group for gpio"

groupadd gpio
chown root:gpio /dev/gpiomem
chmod g+rw /dev/gpiomem

echo "[create-user] create user 'pi'"

username="pi"
password="raspberry"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)

useradd -s /bin/bash -m -p $pass $username

echo "[create-user] add pi to groups"
usermod -a -G adm,dialout,sudo,audio,www-data,video,plugdev,games,users,input,netdev,bluetooth,gpio pi

# echo "[create-user] use bash as efault shell"
# chsh -s /bin/bash
