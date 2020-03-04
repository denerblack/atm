FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

RUN gem install rails -v '5.2.4.1'

ENV SOURCE_HOME .
ENV APP_HOME /app

WORKDIR /app
ADD Gemfile Gemfile.lock /app/

COPY $SOURCE_HOME $APP_HOME
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# RUN bundle install
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
RUN bundle install
