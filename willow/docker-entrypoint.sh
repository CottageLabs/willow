#!/bin/bash

echo "Creating log folder"
mkdir -p $APP_WORKDIR/log


if [ "$RAILS_ENV" = "production" ]; then
    # Verify all the production gems are installed
    bundle check
else
    # use local willow sword
    echo "Switching to local /willow_sword.development"
    bundle config local.willow_sword /willow_sword

    # install any missing development gems (as we can tweak the development container without rebuilding it)
    bundle check || bundle install --without production
fi

## Run any pending migrations
bundle exec rake db:migrate

# check that Fedora is running
FEDORA=$(curl --silent --connect-timeout 30 "http://fedora:8080/" | grep "Fedora Commons Repository")
if [ -n "$FEDORA" ] ; then
    if [ "$WILLOW_SEED" = "true" ] ; then
        echo "(Re)seeding Willow test data... (this can take a few minutes)"
        bundle exec rake willow:seed_test_data["$WILLOW_EMAIL","$WILLOW_PASSWORD","$WILLOW_NAME"]
    fi
else
    echo "ERROR: Fedora is not running"
    exit 1
fi

echo "--------- Starting Willow in $RAILS_ENV mode ---------"
rm -f /tmp/willow.pid
bundle exec rails server -p 3000 -b '0.0.0.0' --pid /tmp/willow.pid
