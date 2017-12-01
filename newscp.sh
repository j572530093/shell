#/bin/sh
#判断是否有参数
if [ $# == 0 ];then
echo '$1=源机器IP
$2=源机器密码
$3=目标机器IP
$4=目标机器密码
$5=源机器路径
$6=目标机器路径
Examples：./scp.sh 192.168.50.61 123456 192.168.50.42 123456 /root/myscript/scp.sh /root'
else
#定义变量
firstip=$1
firstpw=$2
secondip=$3
secondpw=$4
path1=$5
path2=$6
echo "#!/usr/bin/expect
spawn ssh root@${firstip}
set timeout 10
expect {
"*yes/no" { send \"yes\r\"; exp_continue}
"*password:" { send \"${firstpw}\r\" }
}
expect \"#\"
send \"scp -r -o \\'StrictHostKeyChecking no\\' ${path1} root@${secondip}:${path2}\r\"
set timeout 15
expect \"password*\"
send  \"${secondpw}\r\"
set timeout -1
expect \"#\"
send  \"exit\r\"
expect eof" > temp.sh
chmod +x temp.sh && ./temp.sh
rm -rf temp.sh
fi