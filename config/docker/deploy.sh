#!/bin/bash

DOCKER_IMAGE="vsokoltsov/uprogress"
HOST_IP="95.213.251.57"
DOCKER_CONFIG_SCRIPT="docker_config.sh"
KEYS_FILE="keys.sh"
START_SERVER="run_server.sh"
USER="root"
HOME_DIRECTORY="/root"
SERTIFICATE_NAME="production_vsokoltsov.UProgress.pem"

echo "DOCKER DEPLOY"

# BUILD NEW IMAGE
docker rmi -f "$DOCKER_IMAGE:production"
docker build -t "$DOCKER_IMAGE:production" -f "$(pwd)/config/docker/Dockerfile" .

#PUSH TO DOCKER HUB
docker push "$DOCKER_IMAGE:production"

ssh "$USER@$HOST_IP" "rm -f $HOME_DIRECTORY/Dockerfile"
ssh "$USER@$HOST_IP" "rm -f $HOME_DIRECTORY/docker-compose.yml"
ssh "$USER@$HOST_IP" "rm -f $HOME_DIRECTORY/.env.production"
ssh "$USER@$HOST_IP" "rm -f $HOME_DIRECTORY/keys.sh"
ssh "$USER@$HOST_IP" "rm -f $HOME_DIRECTORY/run_server.sh"

#COPY docker_compose file
scp "$(pwd)/docker-compose.production.yml" "$USER@$HOST_IP:$HOME_DIRECTORY"
scp "$(pwd)/config/docker/Dockerfile" "$USER@$HOST_IP:$HOME_DIRECTORY"
#COPY KEYS FILE TO REMOTE SERVER
if [ ! -f "$(pwd)/config/docker/$KEYS_FILE" ]; then
    echo "File keys.sh doesn't found. Pleas create it and put keys right into it."
    exit 1
else
  echo "COPY KEYS"
  scp  "$(pwd)/config/docker/$KEYS_FILE" "$USER@$HOST_IP:$HOME_DIRECTORY/.env.production"
fi

# COPY START SERVER FILE
scp  "$(pwd)/config/docker/$START_SERVER" "$USER@$HOST_IP:$HOME_DIRECTORY"
scp  "$(pwd)/config/certificates/$SERTIFICATE_NAME" "$USER@$HOST_IP:$HOME_DIRECTORY/config/certificates"

#CONNECT_TO SSH AND RUN SCRIPT
ssh "$USER@$HOST_IP" 'bash -s' < "$(pwd)/config/docker/$DOCKER_CONFIG_SCRIPT"
