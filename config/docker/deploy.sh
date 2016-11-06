#!/bin/bash

DOCKER_IMAGE="vsokoltsov/uprogress"

echo "DOCKER DEPLOY"

# BUILD NEW IMAGE
docker build -t "$DOCKER_IMAGE:latest" .

#PUSH TO DOCKER HUB
docker push "$DOCKER_IMAGE:latest"
