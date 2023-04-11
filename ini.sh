#!/bin/bash

#initail

home=""
if [[ -n $1 ]]; then
        user=$1
else
        user="user"
fi

home="/home/$user"

read -n 1 -p "your user is located at $home;press any keys to continue..."

if [ ! -d $home ]; then
        echo -e "dictionary $home doesn't exist"
        exit 0
fi

cd $home
#rm -r $home/*
mkdir $home/Downloads
chown $user:$user $home/Downloads
cd $home/Downloads
sudo apt update
sudo apt upgrade -y
sudo apt install open-vm-tools-desktop -y
sudo apt install git -y
sudo apt install tmux -y
sudo apt install net-tools -y
wget -O "$home/.tmux.conf" https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf
echo -e "set -g mouse on" >> "$home/.tmux.conf"
chown $user:$user $home/.tmux.conf





#screan lock-enable disable

echo -e "user-db:user\nsystem-db:local" > "/etc/dconf/profile/local"

if [ ! -d "/etc/dconf/db/local.d" ]; then
        mkdir "/etc/dconf/db/local.d"
fi
if [ ! -f "/etc/dconf/db/local.d/00-screensaver" ]; then
        touch "/etc/dconf/db/local.d/00-screensaver"
fi

echo -e "[org/gnome/desktop/session]\nidle-delay=uint32 0\n\n[org/gnome/desktop/screensaver]\nlock-enabled=false\nlock-delay=uint32 0" > "/etc/dconf/db/local.d/00-screensaver"

if [ ! -d "/etc/dconf/db/local.d/locks" ]; then
        mkdir "/etc/dconf/db/local.d/locks"
fi
if [ ! -f "/etc/dconf/db/local.d/locks/screensaver" ]; then
        touch "/etc/dconf/db/local.d/locks/screensaver"
fi

echo -e "/org/gnome/desktop/session/idle-delay\n/org/gnome/desktop/screensaver/lock-enabled\n/org/gnome/desktop/screensaver/lock-delay" > "/etc/dconf/db/local.d/locks/screensaver"

dconf update


#install app

##install vscode
rm $home/Downloads/code.deb
wget -O $home/Downloads/code.deb https://az764295.vo.msecnd.net/stable/d045a5eda657f4d7b676dedbfa7aab8207f8a075/code_1.72.2-1665614327_amd64.deb
dpkg -i $home/Downloads/code.deb
rm $home/Downloads/code.deb

##install chrome
rm $home/Downloads/chrome.deb
wget -O $home/Downloads/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i $home/Downloads/chrome.deb
rm $home/Downloads/chrome.deb

#set env

printf "\ncd() { builtin cd \"\$@\" && ls; }" >> $home/.bashrc

shutdown -r now
