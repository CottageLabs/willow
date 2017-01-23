#!/usr/bin/env bash
chown -R "$(id -u)" "/opt/solr/server/solr/mycores"
chmod 700 /opt/solr/server/solr/mycores