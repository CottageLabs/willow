#!/bin/bash

cd /willow 

echo Creating tmp and log
mkdir -p tmp/pids log

echo Mounting willow_source/app, willow_source/bin, willow_source/config, willow_source/db, willow_source/lib, willow_source/public, willow_source/solr, willow_source/spec, willow_source/test, willow_source/vendor

ln -sf /willow_source/config.ru
ln -sf /willow_source/Dockerfile
ln -sf /willow_source/Rakefile
ln -sf /willow_source/README.rdoc
ln -sf /willow_source/startup.sh
ln -sf /willow_source/app
ln -sf /willow_source/bin
ln -sf /willow_source/config
ln -sf /willow_source/db
ln -sf /willow_source/lib
ln -sf /willow_source/public
ln -sf /willow_source/solr
ln -sf /willow_source/spec
ln -sf /willow_source/test
ln -sf /willow_source/vendor

echo Migrating data...
bundle exec rake db:migrate
echo Starting up

bundle exec rails server -p 3000 -b '0.0.0.0'