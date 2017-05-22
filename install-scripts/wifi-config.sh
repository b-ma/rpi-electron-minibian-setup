#!/bin/bash

echo "[WiFi setup]"

echo "WiFi SSID: "
read ssid

echo "WiFi password: "
read passwd

read -r -d '' wpaSupplicant << WPA_SUPPLICANT
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="$ssid"
    scan_ssid=1
    key_mgmt=WPA-PSK
    psk="$passwd"
}
WPA_SUPPLICANT

echo "writing /etc/wpa_supplicant/wpa_supplicant.conf file"
echo "$wpaSupplicant" > "/etc/wpa_supplicant/wpa_supplicant.conf"
# only root can read / write into this file
chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf

echo "WiFi static IP: "
read staticIp

read -r -d '' interfaces << INTERFACES
auto wlan0

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet static
wireless-power off
address $staticIp
netmask 255.255.255.0
gateway 192.168.1.1

wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
INTERFACES

echo "writing /etc/network/interfaces file"
echo "$interfaces" > "/etc/network/interfaces"
