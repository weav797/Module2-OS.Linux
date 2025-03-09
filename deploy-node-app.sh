#!/bin/bash

apt update
App_User=myapp

echo "install node, npm, curl, wget, net-tools"
apt install -y nodejs npm curl net-tools
sleep 15
echo ""
echo "################"
echo ""

node_version=$(node --version)
echo "NodeJS version $node_version installed"

npm_version=$(npm --version)
echo "NPM version $npm_version installed"

echo ""
echo "################"
echo ""

LogDirectory=$1 # Allow the log directory to be supplied as an argument to mitigate/avoid mistakes from manual path entry

if [ -d "$LogDirectory" ]
then
        echo "$LogDirectory already exists"
else
        mkdir -p $LogDirectory
        echo "A new directory $LogDirectory has been created"
fi

# useradd -r -s /usr/sbin/nologin "$App_User" -m
useradd $App_User -m
chown $App_User -R $LogDirectory

runuser -l $App_User -c "wget -vS https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"
runuser -l $App_User -c "tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz"

runuser -l $App_User -c "
    export APP_ENV=dev &&
    export DB_PWD=mysecret &&
    export DB_USER=myuser &&
    export LOG_DIR=$LogDirectory &&
    cd package &&
    npm install &&
    node server.js &"


sleep 5
ps aux | grep node | grep -v grep
netstat -ltnp | grep :3000
