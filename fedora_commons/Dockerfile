FROM tomcat:8.5

# Add Fedora Commons 4.6.1, update default context file, example data and wait-for-it script
ADD context.xml /usr/local/tomcat/conf/context.xml
ADD fcrepo-webapp-4.6.1.war /usr/local/tomcat/webapps/fcrepo.war
ADD example_willow_objects.tar.gz /tmp/
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/wait-for-it.sh
ADD docker-entrypoint.sh /
ENTRYPOINT /docker-entrypoint.sh
