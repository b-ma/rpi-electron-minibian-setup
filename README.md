# RASPBERRY-PI - MINIBIAN Install

### Minibian

1. *Download*

  + https://minibianpi.wordpress.com/download/ (prefer torrent)

2. *Prepare SDCard and intall image*
  + https://www.raspberrypi.org/documentation/installation/installing-images/mac.md
  + http://elinux.org/RPi_Easy_SD_Card_Setup#Using_the_Linux_command_line

```
diskutil list
```

Erase card (see screenshot)
- Format: MS-DOS (FAT)
- Scheme: Master boot record

```
sudo dd bs=1m if=./2016-03-12-jessie-minibian.img of=/dev/disk2
```

> notes: `dd` => `bs=4M` reported `dd: bs: illegal numeric value` but where tried without `sudo`

*connect*

unmount card, install on the raspberry-pi and run it.

3. find rpi on network: 

```
nmap -T4 -sP 192.168.1.0/24
```
 
from [https://minibianpi.wordpress.com/faq/](https://minibianpi.wordpress.com/faq/)
> What is default IP address of MINIBIAN distribution?
> In MINIBIAN dhcp client is enabled by default, so the IP is based on your network settings. You can discover IP with third part tool or looking at the last line in the boot screen.
>
> What is default login?
> Username is **root** and password **raspberry**.

```
ssh root@192.168.1.11
$ root@192.168.1.11's password: raspberry
```

From this point all examples will assume (until a static ip is setup) that the remote address is `192.168.1.11` (change example code accordingly)

4. Install scripts

```
scp -r ./install-scripts/ root@192.168.1.11:/root/
$ root@192.168.1.11's password:
```

in a PI shell

```sh
$ chmod -R 744 /root/install-scripts/
$ /root/install-scripts/env.sh
$ /root/install-scripts/setup-wifi.sh
$ /root/install-scripts/create-user.sh
$ /root/install-scripts/software.sh
```

## Details

### Setup environment

```sh
$ /root/install-scripts/env.sh
```

sources: 
- [WiFi] [https://minibianpi.wordpress.com/how-to/rpi3/](https://minibianpi.wordpress.com/how-to/rpi3/) 

### configure WiFi

```sh
$ /root/install-scripts/wifi-config.sh
```

source:
- [general] [https://minibianpi.wordpress.com/how-to/rpi3/](https://minibianpi.wordpress.com/how-to/rpi3/)
- [general] [https://minibianpi.wordpress.com/how-to/wifi/](https://minibianpi.wordpress.com/how-to/wifi/)
- [wpa_supplicant commented] [https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf](https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf)
- [manual] [https://wiki.archlinux.org/index.php/WPA_supplicant](https://wiki.archlinux.org/index.php/WPA_supplicant)
- [access point] [https://gist.github.com/Lewiscowles1986/fecd4de0b45b2029c390](https://gist.github.com/Lewiscowles1986/fecd4de0b45b2029c390)

#### written files

```sh
# /etc/network/interfaces
auto wlan0

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet static
wireless-power off
address 192.168.1.20
netmask 255.255.255.0
gateway 192.168.1.1

wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```

`chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf`

```sh
# /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="My-box123"
    scan_ssid=1
    key_mgmt=WPA-PSK
    psk="secret"
}
```

@todo - bonjour
http://www.journaldulapin.com/2015/08/31/acceder-au-raspberry-pi-via-bonjour/

### Create 'pi' user

```sh
$ /root/install-scripts/create-user.sh
```

sources: 
- create user from script: [https://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html](https://www.cyberciti.biz/tips/howto-write-shell-script-to-add-user.html)
- add existing user to groups: [https://askubuntu.com/questions/79565/how-to-add-existing-user-to-an-existing-group](https://askubuntu.com/questions/79565/how-to-add-existing-user-to-an-existing-group)

#### `/etc/group` :

```sh
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:pi
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:pi
fax:x:21:
voice:x:22:
cdrom:x:24:
floppy:x:25:
tape:x:26:
sudo:x:27:pi
audio:x:29:pi
dip:x:30:
www-data:x:33:pi
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
gnats:x:41:
shadow:x:42:
utmp:x:43:
video:x:44:pi
sasl:x:45:
plugdev:x:46:pi
staff:x:50:
games:x:60:pi
users:x:100:pi
nogroup:x:65534:
input:x:101:pi
systemd-journal:x:102:
systemd-timesync:x:103:
systemd-network:x:104:
systemd-resolve:x:105:
systemd-bus-proxy:x:106:
crontab:x:107:
messagebus:x:108:
ntp:x:109:
netdev:x:110:pi
ssh:x:111:
bluetooth:x:112:pi
pi:x:1000:
gpio:x:1001:pi
```

### Install softwares

install node, xvfb, and electron globally

node and electron are in `/usr/bin`

### xvfb

usage:

```sh
xvfb-run --server-args="-screen 0, 800x600x8" -a electron ./src/main.js
```

