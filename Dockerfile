FROM ruby:2.6.3-alpine3.8

RUN apk add --update ruby-dev build-base  \
  && apk add  libxslt-dev \
  && apk add mariadb-dev \
  && apk add  tzdata \
  && gem install bundler -v 2.1.4 \
  && rm -rf /var/lib/apt/lists/* \ 
      /var/cache/apk/* \
      /usr/local/bundle/bundler/gems/*/.git \
      /usr/local/bundle/cache/

RUN mkdir /app

COPY Gemfile* /app/

RUN cd app && bundle install --without development

COPY . /app

WORKDIR /app

ARG KEY=623cd79a77b331e4708632bfb13e3362

ARG RAILS_ENV=test

ENV RAILS_MASTER_KEY=$KEY

ENV RAILS_ENV=$RAILS_ENV

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
