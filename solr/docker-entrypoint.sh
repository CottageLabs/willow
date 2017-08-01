#!/bin/bash
#
# Creates the solr cores required for Willow and friends
# SOLR_HOME = data folder, usually mounted as a volume
# SOLR_CONFIG_DIR = a directory of static solr configuration files baked into the Docker image at build time.

set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

cp /opt/solr/server/solr/solr.xml $SOLR_HOME/

. /opt/docker-solr/scripts/run-initdb

SOLR_CONFIG_DIR=/solr_conf

willow_created=$SOLR_HOME/willow_created
geoblacklight_created=$SOLR_HOME/geoblacklight_created

if [ -f $willow_created ] || [ -f $geoblacklight_created ]; then
    echo "skipping solr core creation"
else
    start-local-solr

    if [ ! -f $willow_created ]; then
        echo "Creating willow core(s)"
        /opt/solr/bin/solr create -c "willow_development" -d "$SOLR_CONFIG_DIR/willow_config"
        /opt/solr/bin/solr create -c "willow_test" -d "$SOLR_CONFIG_DIR/willow_config"
        /opt/solr/bin/solr create -c "willow_production" -d "$SOLR_CONFIG_DIR/willow_config"
        touch $willow_created
    fi

    if [ ! -f $geoblacklight_created ]; then
      echo "Creating geoblacklight core(s)"
      /opt/solr/bin/solr create -c "geoblacklight_development" -d "$SOLR_CONFIG_DIR/geoblacklight_config"
      /opt/solr/bin/solr create -c "geoblacklight_test" -d "$SOLR_CONFIG_DIR/geoblacklight_config"
      /opt/solr/bin/solr create -c "geoblacklight_production" -d "$SOLR_CONFIG_DIR/geoblacklight_config"
      touch $geoblacklight_created
    fi

    stop-local-solr
fi

exec solr -f
