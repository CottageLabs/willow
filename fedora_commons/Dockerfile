FROM tomcat:9


# Don't change this, as Tomcat installs to this path
ENV FCREPO4_HOME=/fcrepo4_home

# multi-tenant tomcat
ENV CATALINA_BASE=$FCREPO4_HOME

RUN mkdir -p $FCREPO4_HOME/bin $FCREPO4_HOME/conf $FCREPO4_HOME/lib $FCREPO4_HOME/logs $FCREPO4_HOME/webapps $FCREPO_HOME/work $FCREPO4_HOME/temp
COPY conf $FCREPO4_HOME/conf
COPY setenv.sh $CATALINA_HOME/bin/setenv.sh

ADD https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.7.2/fcrepo-webapp-4.7.2.war $FCREPO4_HOME/webapps/ROOT.war






# custom configuration
#

# RUN rm -Rf $CATALINA_HOME/webapps/
# RUN ls -la $FCREPO4_HOME/webapps/


# Add Fedora Commons 4.7.2, update default context file, example data and wait-for-it script
# COPY docker-healthcheck.sh /usr/local/bin/
#

# COPY docker-entrypoint.sh /
# ADD https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.7.2/fcrepo-webapp-4.7.2.war /usr/local/tomcat/webapps/fcrepo.war
# ADD https://s3.eu-west-2.amazonaws.com/cl-willow/example_willow_objects.tar.gz /tmp/
# ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh /usr/local/bin/wait-for-it.sh
# RUN chmod +x /usr/local/bin/wait-for-it.sh

# ENTRYPOINT /docker-entrypoint.sh

# HEALTHCHECK CMD ["docker-healthcheck.sh"]
