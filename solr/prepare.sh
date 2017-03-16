#!/usr/bin/env bash

docker-entrypoint.sh solr-precreate willow_development /opt/solr/server/solr/willow_config
docker-entrypoint.sh solr-precreate geoblacklight_development /opt/solr/server/solr/geoblacklight_config

