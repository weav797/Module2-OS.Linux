#!/bin/bash

apt update
apt install -y default-jre

# Do not want to see output of java -version on command line
install_result=$(java -version 2>&1 > /dev/null | grep "java version\|openjdk version" | awk '{print substr($3,2,2)}')

if [ "$install_result" == "" ]
then
 echo "No java version found"
elif [ "$install_result" == "1." ]
then
 echo "An old version of Java has been found."
elif [ "$install_result" -ge 11 ]
then
 echo "Java version 11 or greater is installed successfully."
fi
