#!/bin/bash

DOCKER_IMAGE="vsokoltsov/uprogress"
HOST_IP="95.213.251.57"
DOCKER_CONFIG_SCRIPT="docker_config.sh"
KEYS_FILE="keys.sh"
START_SERVER="run_server.sh"
USER="root"
HOME_DIRECTORY="/root"

echo "DOCKER DEPLOY"

# BUILD NEW IMAGE
docker build -t "$DOCKER_IMAGE:latest" -f "$(pwd)/config/docker/Dockerfile" .

#PUSH TO DOCKER HUB
docker push "$DOCKER_IMAGE:latest"

#COPY docker_compose file
scp "$(pwd)/docker-compose.production.yml" "$USER@$HOST_IP:$HOME_DIRECTORY"

#COPY KEYS FILE TO REMOTE SERVER
if [ ! -f "$(pwd)/config/docker/$KEYS_FILE" ]; then
    echo "File keys.sh doesn't found. Pleas create it and put keys right into it."
    exit 1
else
  scp  "$(pwd)/config/docker/$KEYS_FILE" "$USER@$HOST_IP:$HOME_DIRECTORY"
fi
scp  "$(pwd)/config/docker/$KEYS_FILE" "$USER@$HOST_IP:$HOME_DIRECTORY/.env.production"

# COPY START SERVER FILE
scp  "$(pwd)/config/docker/$START_SERVER" "$USER@$HOST_IP:$HOME_DIRECTORY"

#CONNECT_TO SSH AND RUN SCRIPT
ssh "$USER@$HOST_IP" 'bash -s' < "$(pwd)/config/docker/$DOCKER_CONFIG_SCRIPT"
