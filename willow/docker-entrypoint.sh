#!/bin/bash

echo "Creating tmp and log, clearing out PIDs"
mkdir -p $APP_HOME/tmp/pids $APP_HOME/log
rm  -f $APP_HOME/tmp/pids/*

ls -la $APP_HOME/willow_sword

echo "Switching to local willow_sword"
bundle config local.willow_sword $APP_HOME/willow_sword

# Verify all the gems are installed
bundle check || bundle install

# Run any pending migrations
bundle exec rake db:migrate

if [ "$RAILS_ENV" = "production" ]; then
    echo "Compiling assets..."
    bundle exec rake assets:clean assets:precompile
fi

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
