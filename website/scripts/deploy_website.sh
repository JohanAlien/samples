#!/bin/bash

# re-synchronize the package index files
sudo apt-get update || (sleep 15; sudo apt-get update || exit ${1})

echo "Checking if Aptdaemon is installed..."
command aptdcon > /dev/null 2>&1 || { echo >&2 "Aptdaemon is required but it's not installed."; sudo apt-get -y install aptdaemon; }

echo "Checking if Unzip is installed..."
command unzip > /dev/null 2>&1 || { echo >&2 "Unzip is required but it's not installed."; yes|sudo aptdcon --install unzip; }

if [ "$WEBFILE_URL" ]; then
  echo "Deploy from URL..."
  eval "wget $WEBFILE_URL"
  nameZip=${WEBFILE_URL##*/}
  eval "unzip -o $nameZip -d tmp"
else
  echo "Deploy from artifact"
  unzip -o $website_zip -d tmp
fi

if [ ! -d $DOC_ROOT/$CONTEXT_PATH ]; then
  eval "sudo mkdir -p $DOC_ROOT/$CONTEXT_PATH"
fi

eval "sudo rm -rf $DOC_ROOT/$CONTEXT_PATH/*"
eval "sudo mv -f tmp/* $DOC_ROOT/$CONTEXT_PATH"
eval "sudo chown -R www-data:www-data $DOC_ROOT/$CONTEXT_PATH"

echo "End of website install, restart apache2 to update permission on $DOC_ROOT/$CONTEXT_PATH"
sudo /etc/init.d/apache2 restart
