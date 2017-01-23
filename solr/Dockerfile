FROM solr:6.2

ADD willow/solr/config/ /opt/solr/server/solr/willow_config
ADD init/solr/docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

RUN mkdir -p /opt/solr/server/solr/mycores
RUN chown -R 8983:8983 /opt/solr/server/solr/mycores
RUN chmod 777 /opt/solr/server/solr/mycores  # this 777 will be replaced by 700 at runtime after it's mounted as the correct user, not root