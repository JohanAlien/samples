#!/bin/bash

echo "install PHP5..."

sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})

echo "Checking if Aptdaemon is installed..."
command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

yes|sudo aptdcon --install php5 php5-common php5-curl php5-cli php-pear php5-gd php5-mcrypt php5-xmlrpc php5-sqlite php-xml-parser || exit ${1}