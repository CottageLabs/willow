FROM solr:6.4

ENV SOLR_HOME=/solr_home

ADD config/willow $SOLR_HOME/willow_config
ADD config/geoblacklight $SOLR_HOME/geoblacklight_config
COPY docker-entrypoint.sh /

USER root
RUN chown -R solr:solr $SOLR_HOME


USER solr
RUN cp /opt/solr/server/solr/solr.xml $SOLR_HOME
ENTRYPOINT ["/docker-entrypoint.sh"]

