#!/bin/bash

cd /geoblacklight

echo Creating tmp and log
mkdir -p tmp/pids log
rm  -f tmp/pids/*

echo "Mounting geoblacklight source code as a Docker volume with symlinks, except certain temporary directories and other files"

find ../geoblacklight_source/ -maxdepth 1 ! -name "log" ! -name "tmp" ! -name "startup.sh" -exec ln -sf {} ';'

echo "Migrating data..."
bundle exec rake db:migrate

echo "Starting Geoblacklight"
bundle exec rake geoblacklight:server
