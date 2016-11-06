#!/bin/bash

export RAILS_ENV=production
# PULL LATEST IMAGE
docker-compose pull

if [ "$(docker ps | grep vsokoltsov/uprogress)" == ""]
then
  echo "RUN"
  docker-compose up
else
  echo "RESTART"
  docker-compose restart
fi

# if [ ! -f $DOCKER_COMPOSE ]
# then
# else
#
# fi
