# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.3.0-slim
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs

ENV app /root/uprogress
RUN mkdir $app
WORKDIR $app

ENV BUNDLE_PATH /box

ADD . $app
