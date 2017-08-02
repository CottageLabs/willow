#!/bin/bash

# See the associated Fedora Commons Dockerfile for an explanation of important environment variables.

set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

ln -sf $WILLOW_FEDORA_STATIC_DIR/bin $FCREPO4_HOME/
ln -sf $WILLOW_FEDORA_STATIC_DIR/conf $FCREPO4_HOME/
ln -sf $WILLOW_FEDORA_STATIC_DIR/lib $FCREPO4_HOME/

mkdir -p $FCREPO4_HOME/logs $FCREPO4_HOME/webapps $FCREPO4_HOME/work $FCREPO4_HOME/temp

ln -sf $WILLOW_FEDORA_STATIC_DIR/webapps/ROOT.war $FCREPO4_HOME/webapps/ROOT.war

# TODO: create seed test data rather than reindexing pre-cooked data
#fedora_created=$FCREPO4_HOME/fedora_created
#
#if [ -f $fedora_created ]; then
#    echo "Skipping fedora data load"
#else
#    echo "Initialising Fedora for data load"
#    # start Tomcat and Fedora in the background so that this script can continue to run
#    catalina.sh start
#    wait-for-it.sh localhost:8080 --strict --timeout=120 -- echo "Tomcat is running"
#
#    # Wait a few seconds whilst Fedora deploys
#    sleep 5
#
#    echo "Verifying Fedora Commons Rest interface is running"
#    FEDORA=$(curl --connect-timeout 60 -I -s -L http://localhost:8080/rest/ | grep -o "HTTP/1.1 200")
#    if [ "$FEDORA" = "HTTP/1.1 200" ] ; then
#        echo "Restoring Fedora data..."
#        curl --silent --connect-timeout 30 -X POST -d"/tmp/example_willow_objects" "http://localhost:8080/rest/fcr:restore"
#        # wait a moment
#        sleep 1
#        echo "All restored"
#        touch $fedora_created
#
#        catalina.sh stop
#    else
#        catalina.sh stop
#        echo "ERROR: Fedora did not respond as expected, data not restored"
#        exit 1
#    fi
#fi

# Finally, start TomCat in foreground mode
catalina.sh run
