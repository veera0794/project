#!/bin/bash
IMAGE_NAME="react-app"
TAG="latest"

# Optionally, you can set a Dockerfile location if it's not in the current directory
DOCKERFILE_PATH="."

# Build Docker image
echo "Building Docker image: $IMAGE_NAME:$TAG..."
docker build -t "$IMAGE_NAME:$TAG" "$DOCKERFILE_PATH"

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker image $IMAGE_NAME:$TAG built successfully."
else
  echo "Error: Docker image build failed."
  exit 1
fi

