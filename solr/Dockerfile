FROM solr:6.4

ENV SOLR_HOME=/solr_home \
    SOLR_CONFIG_DIR=/solr_conf

USER root
RUN mkdir $SOLR_CONFIG_DIR \
    && chown -R solr:solr $SOLR_CONFIG_DIR

USER solr
ADD config/willow $SOLR_CONFIG_DIR/willow_config
ADD config/geoblacklight $SOLR_CONFIG_DIR/geoblacklight_config

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
