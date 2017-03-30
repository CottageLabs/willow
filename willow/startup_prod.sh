#!/bin/bash

cd /willow
ls -al

echo Creating tmp
mkdir -p tmp/pids

# TODO: merge this file back into startup.sh and use e.g. environmental variables to detect state

bundler -v
echo $BUNDLE_APP_CONFIG
echo $BUNDLE_BIN
echo $BUNDLE_GEMFILE
echo "Bundle path: $BUNDLE_PATH"
ls -al $BUNDLE_PATH
ls -al $BUNDLE_PATH/gems

echo "Migrating data..."
bundle exec rake db:migrate

# check that Fedora is running
FEDORA=$(curl --silent --connect-timeout 30 "http://fedora:8080/" | grep "Fedora Commons Repository")
if [ -n "$FEDORA" ] ; then
    # check that Solr is populated (by reading the numFound attribute)
    DOCS=$(curl --silent --connect-timeout 10 "http://solr:8983/solr/willow_development/select?q=*:*&wt=xml" | grep -oP 'numFound="\K[^"]*')

    if [ "$DOCS" -eq "0" ] ; then
        echo "Reindexing Fedora... (this can take a few minutes)"
        bundle exec rails runner "ActiveFedora::Base.reindex_everything"
        echo "Fedora reindex completed"
    fi
else
    echo "ERROR: Fedora is not running"
    exit 1
fi

echo "Starting Willow"
bundle exec rails server -p 3000 -b '0.0.0.0'
