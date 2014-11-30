#!/bin/bash

# stop apache
service apache2 stop

cd /var/www/cyber-dojo
git reset --hard
git pull
ret=$?
if [ $ret -ne 0 ]; then
  exit
fi

# remove unused exercises
bluefruit_resources/remove_exercises.sh

# cyber-dojo creates folders under katas
chmod g+s katas

# ensure pulled files have correct rights
# don't chmod or chgrp the katas folder (no need and very large)
for folder in app config exercises languages lib log notes public script spec test
do
  echo "chown/chgrp www-data ${folder}"
  eval "chown -R www-data /var/www/cyber-dojo/$folder"
  eval "chgrp -R www-data /var/www/cyber-dojo/$folder"
done

echo "chown/chgrp www-data *"
chown www-data /var/www/cyber-dojo/*
chgrp www-data /var/www/cyber-dojo/*

echo "chown/chgrp www-data .*"
chown www-data /var/www/cyber-dojo/.*
chgrp www-data /var/www/cyber-dojo/.*

echo "chown/chgrp www-data tmp/cache"
mkdir -p tmp/cache
chown www-data /var/www/cyber-dojo/tmp/cache
chgrp www-data /var/www/cyber-dojo/tmp/cache

# start apache
service apache2 start
