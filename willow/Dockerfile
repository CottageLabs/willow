FROM ruby:2.3

# Set up environmental variables - do all in one go to reduce cache layers (see https://docs.docker.com/engine/reference/builder/#env)
# Default to UTF-8 file.encoding
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre \
    RAILS_LOG_TO_STDOUT=yes_please \
    PATH=/fits/fits-1.0.2/:$PATH \
    APP_HOME=/willow \
    BUNDLE_GEMFILE=/willow/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle

# Add backports to apt-get sources
# Install libraries, dependencies, java and fits

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
    libpq-dev \
    libxml2-dev libxslt1-dev \
    libqt4-webkit libqt4-dev xvfb \
    nodejs \
    imagemagick \
    libreoffice \
    ghostscript \
    ffmpeg \
    ufraw \
    bzip2 unzip xz-utils \
    # install open-jdk and ca-certs from jessie-backports
    && apt-get install -t jessie-backports -y --no-install-recommends openjdk-8-jre-headless ca-certificates-java \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& /var/lib/dpkg/info/ca-certificates-java.postinst configure

RUN mkdir -p /fits/ \
    && wget http://projects.iq.harvard.edu/files/fits/files/fits-1.0.2.zip -O /fits/fits-1.0.2.zip \
    && unzip /fits/fits-1.0.2.zip -d /fits \
    && chmod a+x /fits/fits-1.0.2/fits.sh \
    && rm /fits/fits-1.0.2.zip

ADD docker-entrypoint.sh $APP_HOME/docker-entrypoint.sh

WORKDIR $APP_HOME

ENTRYPOINT $APP_HOME/docker-entrypoint.sh
