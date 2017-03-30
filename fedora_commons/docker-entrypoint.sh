#!/bin/bash

set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi

fedora_created=$FCREPO4_HOME/fedora_created

if [ -f $fedora_created ]; then
    echo "Skipping fedora data load"
else
    echo "Initialising Fedora for data load"
    # start Tomcat and Fedora in the background so that this script can continue to run
    catalina.sh start
    sleep 10 # need to wait for Fedora to deploy

    # Check that the Fedora Commons Rest interface is running
    FEDORA=$(curl --connect-timeout 60 -I -s -L http://localhost:8080/rest/ | grep -o "HTTP/1.1 200")

    if [ "$FEDORA" = "HTTP/1.1 200" ] ; then
        echo "Restoring data..."
        curl --silent --connect-timeout 30 -X POST -d"/tmp/example_willow_objects" "http://localhost:8080/rest/fcr:restore"

        # wait a moment
        sleep 1
        echo "All restored"
        touch $fedora_created

        catalina.sh stop
    else
        echo "ERROR: Fedora not running at http://localhost:8080/rest/, data not restored"
        catalina.sh stop
        exit 1
    fi
fi

# Finally, start TomCat in foreground mode
catalina.sh run
