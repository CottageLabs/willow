FROM solr:6.4

RUN mkdir -p /solr_conf
ADD config/willow /solr_conf/willow_config
ADD config/geoblacklight /solr_conf/geoblacklight_config
RUN chown -R solr:solr /solr_conf
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
