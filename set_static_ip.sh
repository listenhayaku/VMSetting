#!/bin/bash
#run this as sudo

#usage ./set_staticip.sh ens33 192.168.1.5/24 192.168.1.254
#      					                   

interfaceCard=$1
newIp=$2
newGateway=$3
currentIp=$(hostname -I)
echo "$interfaceCard:$currentIp"
if [[ -z "$interfaceCard" ]]; then
	echo "plz input interfaceCard"
	exit 1
fi
netsetfile=$(ls /etc/netplan/*.yaml)
echo "netsetfile = $netsetfile"
cp $netsetfile "$netsetfile.bak"
echo -e "network:\n  version: 2\n  renderer: NetworkManager\n  ethernets:\n    $interfaceCard:\n      dhcp4: no\n      addresses: [$newIp]\n      gateway4: $newGateway\n" > $netsetfile


