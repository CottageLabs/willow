FROM tomcat:9

ENV FCREPO4_HOME=/fcrepo4_home
ENV FCREPO4_DATA=/fcrepo4_data
ENV CATALINA_BASE=$FCREPO4_HOME

RUN mkdir -p $FCREPO4_HOME/bin $FCREPO4_HOME/conf $FCREPO4_HOME/lib $FCREPO4_HOME/logs $FCREPO4_HOME/webapps $FCREPO_HOME/work $FCREPO4_HOME/temp
COPY conf $FCREPO4_HOME/conf
COPY setenv.sh $CATALINA_HOME/bin/setenv.sh

# Tip: downloading large files with "curl -L <URL> -o <file>" (rather than with DOCKER ADD) allows for the files to be fully cached
RUN mkdir -p /tmp/ && \
    cd /tmp/ && \
    curl -L https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.7.2/fcrepo-webapp-4.7.2.war -o $FCREPO4_HOME/webapps/ROOT.war && \
    curl -L https://s3.eu-west-2.amazonaws.com/cl-willow/example_willow_objects.tar.gz -o /tmp/example_willow_objects.tar.gz && \
    tar -xzvf example_willow_objects.tar.gz && \
    rm -f /tmp/example_willow_objects.tar.gz

COPY docker-healthcheck.sh /usr/local/bin/
COPY wait-for-it.sh /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK CMD ["docker-healthcheck.sh"]
