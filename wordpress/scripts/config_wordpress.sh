#!/bin/bash
if [ "$CONTEXT_PATH" == "/" ]; then
  CONTEXT_PATH=""
fi

if [ ! -d $DOC_ROOT/$CONTEXT_PATH ]; then
  eval "sudo mkdir -p $DOC_ROOT/$CONTEXT_PATH"
fi

sudo rm -rf $DOC_ROOT/$CONTEXT_PATH/*
sudo mv -f /opt/wordpress/wordpress/* $DOC_ROOT/$CONTEXT_PATH
sudo chown -R www-data:www-data $DOC_ROOT/$CONTEXT_PATH
sudo chmod 644 -R $DOC_ROOT/$CONTEXT_PATH
