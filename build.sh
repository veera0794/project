#!/bin/bash
#IMAGE_NAME="react-app"
#TAG="latest"

# Optionally, you can set a Dockerfile location if it's not in the current directory
#DOCKERFILE_PATH="."

# Build Docker image
#echo "Building Docker image: $IMAGE_NAME:$TAG..."
#docker build -t "$IMAGE_NAME:$TAG" "$DOCKERFILE_PATH"

# Check if the build was successful
#if [ $? -eq 0 ]; then
  #echo "Docker image $IMAGE_NAME:$TAG built successfully."
#else
  #echo "Error: Docker image build failed."
  #exit 1
#fi


#!/bin/bash

# Get current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "Current Branch: $BRANCH_NAME"

# Docker build and push
if [ "$BRANCH_NAME" = "dev" ] ; then
  docker build -t prema07/dev-react-img .
  echo "Prema@1234" | docker login -u "prema07" --password-stdin
  docker push prema07/dev-react-img:latest

elif [ "$BRANCH_NAME" = "main" ]; then
  docker build -t prema07/prod-react-img .
  echo "Prema@1234" | docker login -u "prema07" --password-stdin
  docker push prema07/prod-react-img:latest

fi
