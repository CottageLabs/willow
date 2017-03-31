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
    wait-for-it.sh localhost:8080 --strict --timeout=120 -- echo "Tomcat is running"

    # Wait a few seconds whilst Fedora deploys
    sleep 5

    echo "Verifying Fedora Commons Rest interface is running"
    FEDORA=$(curl --connect-timeout 60 -I -s -L http://localhost:8080/rest/ | grep -o "HTTP/1.1 200")
    if [ "$FEDORA" = "HTTP/1.1 200" ] ; then
        echo "Restoring Fedora data..."
        curl --silent --connect-timeout 30 -X POST -d"/tmp/example_willow_objects" "http://localhost:8080/rest/fcr:restore"
        # wait a moment
        sleep 1
        echo "All restored"
        touch $fedora_created

        catalina.sh stop
    else
        catalina.sh stop
        echo "ERROR: Fedora did not respond as expected, data not restored"
        exit 1
    fi
fi

# Finally, start TomCat in foreground mode
catalina.sh run
