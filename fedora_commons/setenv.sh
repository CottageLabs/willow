#! /bin/sh


# Options as recommended at https://wiki.duraspace.org/display/FEDORA4X/Java+HotSpot+VM+Options+recommendations
export CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true"
export CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8"
export CATALINA_OPTS="$CATALINA_OPTS -server"
export CATALINA_OPTS="$CATALINA_OPTS -Xms1024m"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx2048m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxMetaspaceSize=512m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UseG1GC"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+DisableExplicitGC"


export JAVA_OPTS="$JAVA_OPTS -Djava.security.egd=file:/dev/./urandom"




echo "Using CATALINA_OPTS:"
for arg in $CATALINA_OPTS
do
    echo ">> " $arg
done
echo ""

echo "Using JAVA_OPTS:"
for arg in $JAVA_OPTS
do
    echo ">> " $arg
done
echo "_______________________________________________"
echo ""



#     JAVA_OPTS: >
      #        -Dfile.encoding=UTF-8
      #        -Dfcrepo.home=/mnt/data/fcrepo
      #        -Dfcrepo.ispn.alternative.cache=ispn.alt.cache
      #        -Dfcrepo.ispn.binary.cache=ispn.binary.cache
      #        -Dfcrepo.ispn.cache=ispn.cache
      #        -Dfcrepo.ispn.binary.alternative.cache=ispn.binary.alt.cache
      #        -Dfcrepo.ispn.repo.cache=ispn.repo.cache
      #        -Dfcrepo.ispn.postgresql.username=${POSTGRES_USER}
      #        -Dfcrepo.ispn.postgresql.password=${POSTGRES_PASSWORD}
      #        -Dfcrepo.ispn.postgresql.host=db
      #        -Dfcrepo.ispn.postgresql.port=5432
      #        -Dfcrepo.modeshape.configuration=classpath:/config/jdbc-postgresql/repository.json
      #        -Dfcrepo.modeshape.index.directory=modeshape.index
      #        -Dfcrepo.binary.directory=binary.store
      #        -Dfcrepo.activemq.directory=activemq
      #        -Dcom.arjuna.ats.arjuna.common.ObjectStoreEnvironmentBean.default.objectStoreDir=arjuna.common.object.store
      #        -Dcom.arjuna.ats.arjuna.objectstore.objectStoreDir=arjuna.object.store
      #        -Dnet.sf.ehcache.skipUpdateCheck=true
      #        -Dfcrepo.audit.container=/audit


