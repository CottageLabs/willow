FROM solr:6.2

ADD /willow/solr/config/ /opt/solr/server/solr/willow_config
RUN mkdir -p /opt/solr/server/solr/mycores
RUN chown 8983:8983 /opt/solr/server/solr/mycores
