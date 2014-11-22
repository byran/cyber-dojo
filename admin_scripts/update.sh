#!/bin/bash
# Use to update the cyberdojo git repo on the cyber-dojo server

# get latest source from https://github.com/JonJagger/cyber-dojo
# if it asks for a password just hit return
cd /var/www/cyber-dojo
git reset --hard
git pull
ret=$?
if [ $ret -ne 0 ]; then
  exit
fi

# restart apache
service apache2 restart
