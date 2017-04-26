FROM ruby:2.3

# Add backports to apt-get sources
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

# Set up environmental variables - do all in one go to reduce cache layers (see https://docs.docker.com/engine/reference/builder/#env)
# Default to UTF-8 file.encoding
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872

ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    JAVA_VERSION=8u121 \
    JAVA_DEBIAN_VERSION=8u121-b13-1~bpo8+1 \
    CA_CERTIFICATES_JAVA_VERSION=20161107~bpo8+1 \
    RAILS_LOG_TO_STDOUT=yes_please \
    PATH=/fits/fits-1.0.2/:$PATH \
    APP_HOME=/willow \
    BUNDLE_GEMFILE=/willow/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle


# Installing libraries and dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libpq-dev \
    libxml2-dev libxslt1-dev \
    libqt4-webkit libqt4-dev xvfb \
    nodejs \
    imagemagick \
    libreoffice \
    bzip2 unzip xz-utils \
    openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
    ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
	&& rm -rf /var/lib/apt/lists/*

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home && \
	chmod +x /usr/local/bin/docker-java-home && \
    set -x && [ "$JAVA_HOME" = "$(docker-java-home)" ]

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# install FITS
RUN mkdir -p /fits/ && \
    wget http://projects.iq.harvard.edu/files/fits/files/fits-1.0.2.zip -O /fits/fits-1.0.2.zip && \
    unzip /fits/fits-1.0.2.zip -d /fits && \
    chmod a+x /fits/fits-1.0.2/fits.sh && \
    rm /fits/fits-1.0.2.zip

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD docker-entrypoint.sh $APP_HOME/

RUN bundle install

ENTRYPOINT $APP_HOME/docker-entrypoint.sh