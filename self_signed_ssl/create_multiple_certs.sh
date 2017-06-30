#!/bin/sh

for certificate in $(echo $CERTIFICATES | tr ";" "\n")
do
    count="${certificate//[^|]}"
    if [ "${#count}" != "3" ]; then
        echo "ERROR: certificate definition must have 4 fields: $certificate"
        exit 1
    fi

    remainder="$certificate"
    altname="${remainder%%\|*}"; remainder="${remainder#*\|}";
    if [ "$altname" = "" ]; then
        echo "ERROR: Missing subjectAltName (1st field) in definition: $certificate"
        exit 1
    fi

    commonname="${remainder%%\|*}"; remainder="${remainder#*\|}";
    if [ "$commonname" = "" ]; then
        echo "ERROR: Missing common name (2nd field) in definition: $certificate"
        exit 1
    fi

    certpath="${remainder%%\|*}"; remainder="${remainder#*\|}";
    if [ "$certpath" = "" ]; then
        echo "ERROR: Missing certificate path (3rd field) in definition: $certificate"
        exit 1
    fi
    if [ ! -d $(dirname "$certpath") ]; then
        echo "ERROR: Directory for certificate path ($certpath) does not exist"
        exit 1
    fi

    keypath="${remainder%%\|*}"; remainder="${remainder#*\|}";
    if [ "$keypath" = "" ]; then
        echo "ERROR: Missing key path (4th field) in definition: $certificate"
        exit 1
    fi
    if [ ! -d $(dirname "$keypath") ]; then
        echo "ERROR: Directory for key path ($keypath) does not exist"
        exit 1
    fi

    if [ ! -f "$certpath" ] || [ ! -f "$keypath" ]; then
        echo "Generating certificate for $commonname ($altname)"
        echo "Writing certificate to: $certpath"

        export ALTNAME=$altname
        openssl req -x509 -sha256 -nodes -newkey rsa:4096 -keyout "$keypath" -out "$certpath" -days 999 -subj "/CN=$commonname" -config /etc/ssl/openssl.cnf -extensions SAN
    else
        echo "Not regenerating $certpath and $keypath because they already exist"
    fi
done
