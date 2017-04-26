#!/bin/bash

cd /willow 

echo Creating tmp and log
mkdir -p tmp/pids log
rm  -f tmp/pids/*

echo "Mounting willow source code as a Docker volume with symlinks, except certain temporary directories and other files"

find ../willow_source/ -maxdepth 1 ! -name "log" ! -name "tmp" ! -name "startup.sh" -exec ln -sf {} ';'

echo "Running database migrations..."
bundle exec rake db:migrate

if [ "$RAILS_ENV" = "production" ]; then
    echo "Compiling assets..."
    bundle exec rake assets:clean assets:precompile
fi

# TODO: create seed test data rather than reindexing pre-cooked data
# check that Fedora is running
FEDORA=$(curl --silent --connect-timeout 30 "http://fedora:8080/" | grep "Fedora Commons Repository")
if [ -n "$FEDORA" ] ; then
   echo "(Re)seeding test data... (this can take a few minutes)"
   bundle exec rake willow:seed_test_data["$WILLOW_EMAIL","$WILLOW_PASSWORD","$WILLOW_NAME"]
else
    echo "ERROR: Fedora is not running"
    exit 1
fi

echo "Starting Willow"
bundle exec rails server -p 3000 -b '0.0.0.0'
