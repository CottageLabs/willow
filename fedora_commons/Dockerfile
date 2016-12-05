FROM tomcat:8.5

# Download Fedora Commons 4.6, update default context file
ADD context.xml /usr/local/tomcat/conf/context.xml

RUN wget https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-4.6.0/fcrepo-webapp-4.6.0.war -O /usr/local/tomcat/webapps/fcrepo.war


