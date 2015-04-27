#!/bin/bash
echo "Git install..."

sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})

echo "Checking if Aptdaemon is installed..."
command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

yes|sudo aptdcon --install git || exit ${1}

echo "Configure git (get from ENV git_user / git_email)"
sudo /usr/bin/git config --global user.name $GIT_USER
sudo /usr/bin/git config --global user.email $GIT_EMAIL
