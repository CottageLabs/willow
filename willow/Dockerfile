FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential

# for postgres
RUN apt-get install -y --no-install-recommends libpq-dev

# for nokogiri
RUN apt-get install -y --no-install-recommends libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y --no-install-recommends libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y --no-install-recommends nodejs

# for imagemagick
RUN apt-get install -y --no-install-recommends imagemagick

ENV APP_HOME /willow

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install

ADD startup.sh $APP_HOME/
