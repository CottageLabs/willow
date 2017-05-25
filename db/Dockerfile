FROM postgres:9.5

COPY docker-healthcheck.sh /usr/local/bin/

HEALTHCHECK CMD ["docker-healthcheck.sh"]
