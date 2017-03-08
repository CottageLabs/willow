#!/bin/bash

cd /geoblacklight

echo Creating tmp and log
mkdir -p tmp/pids log
rm  -f tmp/pids/*

echo "Mounting geoblacklight source code as a Docker volume with symlinks, except certain temporary directories and other files"

find ../geoblacklight_source/ -maxdepth 1 ! -name "log" ! -name "tmp" ! -name "startup.sh" -exec ln -sf {} ';'

echo "Migrating data..."
bundle exec rake db:migrate

echo "Seeding Solr with some data"
bundle exec rake geoblacklight:solr:seed

echo "Starting Geoblacklight"
bundle exec rails s -p 3010 -b '0.0.0.0'

