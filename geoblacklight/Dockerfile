FROM ruby:2.3

# install sqlite3
RUN apt-get install -y --no-install-recommends libsqlite3-dev

# install node
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y --no-install-recommends nodejs

ENV APP_HOME /geoblacklight

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/geoblacklight_bundle

RUN bundle install

ADD startup.sh $APP_HOME/
