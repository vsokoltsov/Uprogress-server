# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.3.0-slim
# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs

# Define where our application will live inside the image
ENV RAILS_ROOT /root/uprogress

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT
