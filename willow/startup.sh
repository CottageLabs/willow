#!/bin/bash

cd /willow 

echo Creating tmp and log
mkdir -p tmp/pids log

echo "Mounting willow source code as a Docker volume with symlinks, except certain temporary directories and other files"

find ../willow_source/ -maxdepth 1 ! -name "log" ! -name "tmp" ! -name "startup.sh" -exec ln -sf {} ';'

echo Migrating data...
bundle exec rake db:migrate
echo Starting up

bundle exec rails server -p 3000 -b '0.0.0.0'