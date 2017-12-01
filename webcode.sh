echo 'https://lin.jing:572530093Lj@gitlab.com' > /root/.git-credentials
git config --global credential.helper store
echo '#!/usr/bin/expect
set gituser lin.jing  
set gitpass 572530093Lj  
set timeout 3  
spawn git clone http://192.168.50.4:5081/trunk/danaos.git ./danaos
set timeout -1
expect {  
"Username*" { send "$gituser\r"; exp_continue}  
"Password*" { send "$gitpass\r" }  
} 
expect eof' > gitauth.sh
chmod -R +x gitauth.sh
./gitauth.sh
rm -rf ./gitauth.sh
#修改web端代码中写死的ip地址为本机ip
cd $myPath/src/utils
sed -i "s/"127.0.0.*\"\;"/"`ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2 | cut -d '/' -f1 | head -1`\"\;"/" config.js
sleep 2
source /etc/profile
cd -
cd ./danaos/web
#编译前端代码
npm install
npm start
else
cd $myPath
git pull
fi
