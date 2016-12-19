#!/bin/bash

DOCKER_IMAGE="vsokoltsov/uprogress"
HOST_IP="35.162.216.101"
DOCKER_CONFIG_SCRIPT="docker_config.sh"
KEYS_FILE="keys.sh"
START_SERVER="run_server.sh"

echo "DOCKER DEPLOY"

# BUILD NEW IMAGE
docker build -t "$DOCKER_IMAGE:latest" -f "$(pwd)/config/docker/Dockerfile.prod" .

#PUSH TO DOCKER HUB
docker push "$DOCKER_IMAGE:latest"

#COPY docker_compose file
scp "$(pwd)/docker-compose.production.yml" "ec2-user@$HOST_IP:/home/ec2-user"

#COPY KEYS FILE TO REMOTE SERVER
if [ ! -f "$(pwd)/config/docker/$KEYS_FILE" ]; then
    echo "File keys.sh doesn't found. Pleas create it and put keys right into it."
    exit 1
else
  scp  "$(pwd)/config/docker/$KEYS_FILE" "ec2-user@$HOST_IP:/home/ec2-user"
fi
scp  "$(pwd)/config/docker/$KEYS_FILE" "ec2-user@$HOST_IP:/home/ec2-user/.ssh/environment"

# COPY START SERVER FILE
scp  "$(pwd)/config/docker/$START_SERVER" "ec2-user@$HOST_IP:/home/ec2-user"

#CONNECT_TO SSH AND RUN SCRIPT
ssh "ec2-user@$HOST_IP" 'bash -s' < "$(pwd)/config/docker/$DOCKER_CONFIG_SCRIPT"
