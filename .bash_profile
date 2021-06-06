#!/bin/bash
folder=kali-fs
dlink="https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/APT"
mkdir /usr/local/bin
printf "\n\n\n\n\n"
echo -e "\e[32m[\e[31m*\e[32m] \e[34minstalling"
printf "\n\n\n\n\n\n"
gpg --keyserver hkp://keys.gnupg.net --recv-key 7D8D0BF6
gpg --fingerprint 7D8D0BF6
gpg -a --export 7D8D0BF6 | apt-key add -
apt-mark hold udisks2
[ ! -f /root/.parrot ] && apt-get update || echo "Parrot detected, not updating apt cache since that will break the whole distro"
apt-get install keyboard-configuration -y
apt-get install sudo wget -y
apt-get install xfce4 xfce4-terminal tigervnc-standalone-server -y
apt-get install xfe -y
apt update -y && apt install wget sudo dbus-x11 -y
apt install tigervnc-standalone-server -y
apt-get clean

#Setup the necessary files
mkdir ~/.vnc
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/xstartup -P ~/.vnc/
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-start -P /usr/local/bin/
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-stop -P /usr/local/bin/

chmod +x ~/.vnc/xstartup
chmod +x /usr/local/bin/vncserver-start
chmod +x /usr/local/bin/vncserver-stop
if [ ! -f /usr/local/bin/vncserver-start ]; then
wget --tries=20  $dlink/LXDE/vncserver-start -O /usr/local/bin/vncserver-start
    wget --tries=20 $dlink/LXDE/vncserver-stop -O /usr/local/bin/vncserver-stop
    chmod +x /usr/local/bin/vncserver-stop
    chmod +x /usr/local/bin/vncserver-start
fi
if [ ! -f /usr/bin/vncserver ]; then
    apt install tigervnc-standalone-server -y
fi
clear 
echo 'Installing browser'
apt install firefox-esr -y
clear 
echo " "

echo "Running browser patch"
wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Uninstall/ubchromiumfix.sh && chmod +x ubchromiumfix.sh
./ubchromiumfix.sh && rm -rf ubchromiumfix.sh

echo "You can now start vncserver by running vncserver-start"
echo " "
echo "It will ask you to enter a password when first time starting it."
echo " "
echo "The VNC Server will be started at 127.0.0.1:5901"
echo " "
echo "You can connect to this address with a VNC Viewer you prefer"
echo " "
echo "Connect to this address will open a window with Xfce4 Desktop Environment"
echo " "
echo " "
echo " "
echo "Running vncserver-start"
echo " "
echo " "
echo " "
echo "To Kill VNC Server just run vncserver-stop"
echo " "
echo " "
echo " "

echo "export DISPLAY=":1"" >> /etc/profile
source /etc/profile

vncserver-start
rm -rf /root/.bash_profile
