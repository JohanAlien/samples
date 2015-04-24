#!/bin/bash

echo "Install PHP module for Mysql..."

# re-synchronize the package index files
sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})

echo "Checking if Aptdaemon is installed..."
command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

yes|sudo aptdcon --install php5-mysql || exit ${1}

echo "restart apache2 to launch php5-mysql"
sudo service apache2 restart
