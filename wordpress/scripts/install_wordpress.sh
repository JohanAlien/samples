#!/bin/bash

echo "Install wordpress from directory ${PWD}, download url is $WEBFILE_URL"

# re-synchronize the package index files
sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})

echo "Checking if Aptdaemon is installed..."
command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

echo "Checking if Unzip is installed..."
command unzip > /dev/null 2>&1 || { echo >&2 "Unzip is required but it's not installed."; yes|sudo aptdcon --install unzip; }

nameZip=${WEBFILE_URL##*/}
echo "Download last build of Wordpress from $WEBFILE_URL to /tmp/$nameZip"
wget $WEBFILE_URL -O /tmp/$nameZip

echo "Unzip wordpress from /tmp/$nameZip to /opt/wordpress"
sudo unzip -o /tmp/$nameZip -d /opt/wordpress
