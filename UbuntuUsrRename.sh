#!/bin/bash

target1="/etc/passwd"
target2="/etc/shadow"
target3="/etc/group"

if [[ $1 == "" ]] || [[ $2 == "" ]]; then
	echo "UbuntuUsrRename.sh usage: ./UbuntuUsrRename.sh {oldusername} {newusername}"
	exit 0
fi

sed -i "s/$1/$2/g" $target1
sed -i "s/$1/$2/g" $target2
sed -i "s/$1/$2/g" $target3s

