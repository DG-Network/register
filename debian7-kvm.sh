#!/bin/bash
# Created by https://www.hostingtermurah.net
flag=0
if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com);

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`

MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
	MYIP2="s/xxxxxxxxx/$MYIP/g";
fi

#vps="dg-network";
vps="dg-network";

#if [[ $vps = "dg-network" ]]; then
	#source="http://"
#else
	source="https://raw.githubusercontent.com/DG-Network"
#fi

# go to root
cd

# check registered ip
wget -q -O IP $source/register/master/IP.txt
if ! grep -w -q $MYIP IP; then
	echo "Sorry, hanya IP yang terdaftar yang bisa menggunakan SCRIPT PREMIUM ini!"
	if [[ $vps = "dg-network" ]]; then
		echo "Silahkan Hubungi Admin DG-Network | SoelHadi_Newbie (WhatsApp: 087864334333)"
	else
		echo "Silahkan Hubungi Admin DG-Network | SoelHadi_Newbie (WhatsApp: 087864334333)"
	fi
	rm /root/IP
	exit
fi
wget https://raw.githubusercontent.com/DG-Network/installer-VPS-Debian7/master/uptodate-script.sh -O - -o /dev/null|sh
