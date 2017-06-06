FROM postgres:9.5

COPY docker-healthcheck.sh /usr/local/bin/

COPY docker-entrypoint-initdb.d/ docker-entrypoint-initdb.d/

HEALTHCHECK CMD ["docker-healthcheck.sh"]
