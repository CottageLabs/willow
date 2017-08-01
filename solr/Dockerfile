FROM solr:6.4

ENV SOLR_CONFIG_DIR=/solr_conf \
    SOLR_HOME=/solr_home

USER root
RUN mkdir $SOLR_HOME $SOLR_CONFIG_DIR
RUN chown -R solr:solr $SOLR_HOME $SOLR_CONFIG_DIR

USER solr
ADD config/willow $SOLR_CONFIG_DIR/willow_config
ADD config/geoblacklight $SOLR_CONFIG_DIR/geoblacklight_config
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

