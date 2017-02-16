#!/bin/sh

echo Initialising Fedora

# check to see if a marker file exists indicating the data has already been restored
if [ ! -e /mnt/data/fcrepo/.example_willow_objects ] ;  then
    echo "Restoring willow objects to Fedora"
    # start Tomcat and Fedora in the background so that this script can continue to run
    catalina.sh start
    wait-for-it.sh "localhost:8080" -t 30 --quiet
    if [ "$?" -eq "0" ] ; then
        # Tomcat is running, now check whether Fedora is running
        # wait a few more seconds for Fedora to boot
        sleep 2
        # verify Fedora is running
        FEDORA=$(curl --silent --connect-timeout 30 "http://localhost:8080/fcrepo/" | grep "Fedora Commons Repository")
        if [ -n "$FEDORA" ] ; then
            echo "Restoring data..."

            curl --silent --connect-timeout 60 -X POST -d"/tmp/example_willow_objects" "http://localhost:8080/fcrepo/rest/fcr:restore"

            # wait a moment
            sleep 1
            echo "All restored"

            mkdir -p /mnt/data/fcrepo/
            date >> /mnt/data/fcrepo/.example_willow_objects
        else
            echo "Failed to start Fedora"
        fi
        echo "Stopping Tomcat"
        catalina.sh stop
    else
        echo "Failed to start Tomcat"
    fi
fi

# Finally, start TomCat in foreground mode
catalina.sh run
