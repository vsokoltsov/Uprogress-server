# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.3.0-slim
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/docker_example
ENV GEM_HOME /box
ENV BUNDLE_PATH /box
ENV PATH /box/bin:$PATH

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
# ONBUILD COPY Gemfile Gemfile
#
# ONBUILD COPY Gemfile.lock Gemfile.lock

ONBUILD COPY Gemfile Gemfile

ONBUILD COPY Gemfile.lock Gemfile.lock

# Finish establishing our Ruby enviornment
ONBUILD RUN bundle install --deployment

ENV RAILS_ENV production
ENV RACK_ENV production

# Copy the Rails application into place
COPY . .

# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)
# CMD [ "bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000" ]
# "bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"
