FROM tomcat:8.5

# Add Fedora Commons 4.6.1, update default context file, example data and wait-for-it script
COPY docker-healthcheck.sh /usr/local/bin/
COPY context.xml /usr/local/tomcat/conf/context.xml
COPY fcrepo-webapp-4.6.1.war /usr/local/tomcat/webapps/fcrepo.war
COPY docker-entrypoint.sh /
ADD example_willow_objects.tar.gz /tmp/
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh

ENTRYPOINT /docker-entrypoint.sh

HEALTHCHECK CMD ["docker-healthcheck.sh"]
