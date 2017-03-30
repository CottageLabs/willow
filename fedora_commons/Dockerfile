FROM tomcat:9

ENV FCREPO4_HOME=/fcrepo4_home
ENV FCREPO4_DATA=/fcrepo4_data
ENV CATALINA_BASE=$FCREPO4_HOME

RUN mkdir -p $FCREPO4_HOME/bin $FCREPO4_HOME/conf $FCREPO4_HOME/lib $FCREPO4_HOME/logs $FCREPO4_HOME/webapps $FCREPO_HOME/work $FCREPO4_HOME/temp
COPY conf $FCREPO4_HOME/conf
COPY setenv.sh $CATALINA_HOME/bin/setenv.sh

ADD https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.7.2/fcrepo-webapp-4.7.2.war $FCREPO4_HOME/webapps/ROOT.war
ADD https://s3.eu-west-2.amazonaws.com/cl-willow/example_willow_objects.tar.gz /tmp/example_willow_objects.tar.gz
RUN cd /tmp/ && tar -xzvf example_willow_objects.tar.gz && rm -f /tmp/example_willow_objects.tar.gz && cd /

COPY docker-healthcheck.sh /usr/local/bin/
COPY wait-for-it.sh /usr/local/bin/
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK CMD ["docker-healthcheck.sh"]
