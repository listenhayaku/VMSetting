#!/bin/bash

target1="/etc/passwd"
target2="/etc/shadow"
target3="/etc/group"
whoami=$(whoami)

if [ $whoami != "root" ]; then
	echo "you are not root"
	exit 0
fi

if [[ $1 == "" ]] || [[ $2 == "" ]]; then
	echo "UbuntuUsrRename.sh usage: ./UbuntuUsrRename.sh {oldusername} {newusername}"
	exit 0
fi

sed -i "s/$1/$2/g" $target1
sed -i "s/$1/$2/g" $target2
sed -i "s/$1/$2/g" $target3

mv /home/$1 /home/$2

passwd $2