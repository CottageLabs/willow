solr start
chown -R 8983:8983 /opt/solr/server/solr/mycores

solr solr-precreate willow_development /opt/solr/server/solr/willow_config/
#solr create_core -c willow_development -d /opt/solr/server/solr/willow_config/
# solr create_core -c willow_test
# solr create_core -c willow_production
solr stop
# cp -R /opt/solr/server/solr/willow_conf/* /opt/solr/server/solr/willow_development/conf
# cp -R /opt/solr/server/solr/willow_conf/* /opt/solr/server/solr/willow_test/conf
# cp -R /opt/solr/server/solr/willow_conf/* /opt/solr/server/solr/willow_production/conf
