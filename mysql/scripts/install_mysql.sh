#!/bin/bash

echo "Debian based MYSQL install..."

command -v aptdcon
if [ ! $? -eq 0 ]; then
   echo "Aptdaemon is required but it's not installed."
   a=1
   until [ $a -eq "0" ]; do
      echo "Installing Aptdaemon..."
      sudo aptitude -y install aptdaemon
      a=$?
      sleep 5
   done
fi

#echo "Checking if Aptdaemon is installed..."
#command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

yes|sudo DEBIAN_FRONTEND=noninteractive aptdcon --allow-unauthenticated --install mysql-server-5.5 pwgen || exit ${1}

sudo /etc/init.d/mysql stop
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/lib/mysql/*
echo "MySQL Installation complete."
