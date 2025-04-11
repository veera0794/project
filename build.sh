#!/bin/bash
# BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "Current Branch: $BRANCH_NAME"

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PASS" ]; then
  echo "Docker credentials are missing!"
  exit 1
fi
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

# Check if login was successful
if [ $? -ne 0 ]; then
  echo "Docker login failed!"
  exit 1
fi

# Docker build and push
if [ "$BRANCH_NAME" = "dev" ] ; then
  docker build -t prema07/dev-react-img .
  # echo "Prema@1234" | docker login -u "prema07" --password-stdin
  docker push prema07/dev-react-img:latest

elif [ "$BRANCH_NAME" = "main" ]; then
  docker build -t prema07/prod-react-img .
  # echo "Prema@1234" | docker login -u "prema07" --password-stdin
  docker push prema07/prod-react-img:latest

else
  echo "No deployment configured for branch: $BRANCH_NAME"
  exit 0

fi
