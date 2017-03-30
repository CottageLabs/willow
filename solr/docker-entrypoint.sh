#!/bin/bash
#
# Creates the solr cores required for Willow and friends

set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi


. /opt/docker-solr/scripts/run-initdb


willow_created=$SOLR_HOME/willow_created
geoblacklight_created=$SOLR_HOME/geoblacklight_created

if [ -f $willow_created ] || [ -f $geoblacklight_created ]; then
    echo "skipping solr core creation"
else
    start-local-solr

    if [ ! -f $willow_created ]; then
        echo "Creating willow core(s)"
        /opt/solr/bin/solr create -c "willow_development" -d "$SOLR_HOME/willow_config"
        /opt/solr/bin/solr create -c "willow_test" -d "$SOLR_HOME/willow_config"
        /opt/solr/bin/solr create -c "willow_production" -d "$SOLR_HOME/willow_config"
        touch $willow_created
    fi

    if [ ! -f $geoblacklight_created ]; then
      echo "Creating geoblacklight core(s)"
      /opt/solr/bin/solr create -c "geoblacklight_development" -d "$SOLR_HOME/geoblacklight_config"
      /opt/solr/bin/solr create -c "geoblacklight_test" -d "$SOLR_HOME/geoblacklight_config"
      /opt/solr/bin/solr create -c "geoblacklight_production" -d "$SOLR_HOME/geoblacklight_config"
      touch $geoblacklight_created
    fi

    stop-local-solr
fi

exec solr -f
