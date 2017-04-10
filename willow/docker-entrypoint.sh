#!/bin/bash

cd /willow 

echo Creating tmp and log
mkdir -p tmp/pids log
rm  -f tmp/pids/*

echo "Mounting willow source code as a Docker volume with symlinks, except certain temporary directories and other files"

find ../willow_source/ -maxdepth 1 ! -name "log" ! -name "tmp" ! -name "startup.sh" -exec ln -sf {} ';'

echo "Migrating data..."
bundle exec rake db:migrate

# check that Fedora is running
FEDORA=$(curl --silent --connect-timeout 30 "http://fedora:8080/" | grep "Fedora Commons Repository")
if [ -n "$FEDORA" ] ; then
    # check that Solr is populated (by reading the numFound attribute)
    DOCS=$(curl --silent --connect-timeout 10 "http://solr:8983/solr/willow_development/select?q=*:*&wt=xml" | grep -oP 'numFound="\K[^"]*')

    if [ "$DOCS" -eq "0" ] ; then
        echo "Reindexing Willow test data in Solr... (this can take a few minutes)"
        bundle exec rake willow:reindex_test_data
    else
        echo "Not reindexing Fedora data to Solr as there is existing data in Solr"
    fi
else
    echo "ERROR: Fedora is not running"
    exit 1
fi

echo "Starting Willow"
bundle exec rails server -p 3000 -b '0.0.0.0'
