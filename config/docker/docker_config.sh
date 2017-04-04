#!/bin/bash

# IMPORT KEYS
echo "IMPORT KEYS"
source "/root/.env"
export RAILS_ENV="production"
export S3_BUCKET=$S3_BUCKET
export S3_KEY=$S3_KEY
export S3_SECRET=$S3_SECRET
export SECRET_KEY_BASE=$SECRET_KEY_BASE
export JWT_SECRET=$JWT_SECRET
# RENAME docker-compose.yml file
mv docker-compose.production.yml docker-compose.yml

# delete existing image
echo "REMOVE EXISTED IMAGE"
docker system prune -f
docker rmi -f vsokoltsov/uprogress:production
# docker-compose rm -f

# PULL LATEST IMAGE
docker pull vsokoltsov/uprogress:production
#CHECK IF CONTAINER RUNNING
running_docker="$(docker ps | grep vsokoltsov/uprogres)"
if [ $running_docker == ""]
then
  echo "BUILD"
  docker-compose build
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
