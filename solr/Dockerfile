FROM solr:6.2

ADD willow/solr/config/ /opt/solr/server/solr/willow_config
ADD init/solr/docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/
RUN ls -l /opt/solr/server/solr/