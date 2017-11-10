FROM ruby:2.4.1

RUN apt-get update -qq && apt-get install -y build-essential

RUN apt-get install -y \
  libpq-dev \
  libxml2-dev \
  libxslt1-dev \
  nodejs

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile* /usr/src/app/
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install

COPY . /usr/src/app
