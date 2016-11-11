#!/bin/bash

DOCKER_IMAGE="vsokoltsov/uprogress"
HOST_IP="52.90.29.157"
DOCKER_CONFIG_SCRIPT="docker_config.sh"

echo "DOCKER DEPLOY"

# BUILD NEW IMAGE
# docker build -t "$DOCKER_IMAGE:latest" .

#PUSH TO DOCKER HUB
# docker push "$DOCKER_IMAGE:latest"

#COPY docker_compose file
scp "$(pwd)/docker-compose.production.yml" "ec2-user@$HOST_IP:/home/ec2-user"

#CONNECT_TO SSH AND RUN SCRIPT
ssh "ec2-user@$HOST_IP" 'bash -s' < "$(pwd)/config/docker/$DOCKER_CONFIG_SCRIPT"
