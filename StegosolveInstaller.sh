#!/bin/bash

who=$(whoami)
echo $who
if [ $who == "root" ]; then
	:
else
	echo "execute this script as root!"
	exit 0
fi

apt update
apt install libc6-i386 -y
apt install libc6-x32 -y
#apt install libc 我記得還有一個
apt install openjdk-11-jdk -y
wget http://www.caesum.com/handbook/Stegsolve.jar -O stegsolve.jar
cp stegsolve.jar /usr/bin/stegsolve
rm stegsolve.jar
