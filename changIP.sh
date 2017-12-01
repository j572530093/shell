#!/bin/sh
#-------自动修改固定ip-------#
#author:linjing              #
#versions:1.0                #
#----------------------------#


#-------自定义变量-----------#
read -p "Please enter the fixed IP:" ipname
localnetpath=/etc/sysconfig/network-scripts/
netm=255.255.255.0
gate=192.168.50.1
nameserver=8.8.8.8
#-------修改ip的函数---------#
function changeip()
{
#获取网卡目录下的第一个网卡名
ls ${localnetpath} > txt
netname=`head -1 txt`
echo "[  OK  ]................The native network card is called：${netname}"
netpath=${localnetpath}${netname}
sleep 1
#判断输入的ip地址是否为空
if [ ! -n "$ipname" ];then
	echo "The IP address of the input is empty, please enter again"
	exit 0
	else
	echo "To determine whether a network card file exist..."
	sleep 1
	if [ -e $netpath ];then
		echo "[  OK  ]................Is creating a fixed IP:$ipname"
		echo "TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
ONBOOT=yes
NETMASK=$netm
GATEWAY=$gate
IPADDR=$ipname" >$netpath
sleep 1
echo "[ INFO ]................The subnet mask is：$netm
[ INFO ]................The default gateway is：$gate"	
	else
		echo "[ERRO]................Network card file does not exist!"
		read -p "Create?" yn
		if [ $yn == yes -o $yn == y ];then
		touch ifcfg-eno16777984
		echo "TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
ONBOOT=yes
NETMASK=$netm
GATEWAY=$gate
IPADDR=$ipname" >$netpath
		else
			exit 0
		fi
	fi
fi
systemctl restart network
echo "nameserver ${gate}
nameserver ${nameserver}" >/etc/resolv.conf
systemctl restart network
sleep 2
echo "[  OK  ]................Fixed IP has been set up:$ipname"
rm -rf txt
ping -c 3 www.baidu.com
}
#--------函数执行-----------#
changeip