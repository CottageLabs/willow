FROM tomcat:9

ENV FCREPO4_HOME=/fcrepo4_home \
    FCREPO4_DATA=/fcrepo4_data \
    CATALINA_BASE=/fcrepo4_home

RUN mkdir -p $FCREPO4_HOME/bin \
    $FCREPO4_HOME/conf \
    $FCREPO4_HOME/lib \
    $FCREPO4_HOME/logs \
    $FCREPO4_HOME/webapps \
    $FCREPO_HOME/work \
    $FCREPO4_HOME/temp \
    /tmp \
    # Tip: downloading large files with "curl -L <URL> -o <file>" (rather than with DOCKER ADD) allows for the files to be fully cached
    && curl -L https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.7.2/fcrepo-webapp-4.7.2.war -o $FCREPO4_HOME/webapps/ROOT.war

COPY conf $FCREPO4_HOME/conf
COPY setenv.sh $CATALINA_HOME/bin/setenv.sh
COPY docker-healthcheck.sh /usr/local/bin/
COPY wait-for-it.sh /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK CMD ["docker-healthcheck.sh"]
