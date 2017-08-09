FROM solr:6.4

ENV SOLR_HOME=/solr_home \
    SOLR_CONFIG_DIR=/solr_conf

USER root
RUN mkdir $SOLR_CONFIG_DIR \
    && chown -R solr:solr $SOLR_CONFIG_DIR

# The following command is completely pointless when the container is run on
# a different system from the one that built it. In those cases, $SOLR_HOME
# is just replaced by the contents of the volume mounted over it at runtime.
#
# However, on local development machines this command helps re-init a volume
# with the correct permissions after the volume has been deleted and recreated.
# This is despite the fact that obviously everything in this Dockerfile only
# relates to build-time, not run-time. Docker does some permissions and
# ownership munging.
# FIXME how do images like postgres do this and why is it only necessary for Solr?
RUN mkdir -p $SOLR_HOME && chown -R solr:solr $SOLR_HOME

USER solr
ADD config/willow $SOLR_CONFIG_DIR/willow_config
ADD config/geoblacklight $SOLR_CONFIG_DIR/geoblacklight_config

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
