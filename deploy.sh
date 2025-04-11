#!/bin/bash

#echo "Deployment Branch: $BRANCH_NAME"
echo "Deployment Branch: $BRANCH_NAME"

if [ -z "$BRANCH_NAME" ]; then
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
    echo "Branch Name Detected: $BRANCH_NAME"
fi

# Stop and remove the container if it exists
if [ $(docker ps -aq -f name=my-reactapp-container) ]; then
    echo "Stopping existing container..."
    docker stop my-reactapp-container
    echo "Removing existing container..."
    docker rm my-reactapp-container
else
    echo "No existing container found. Proceeding with deployment..."
fi

# Pull the correct image based on the branch
if [ "$BRANCH_NAME" = "dev" ]; then
    echo "Pulling development image..."
    docker pull prema07/dev-react-img:latest
    echo "Starting development container..."
    docker run -d -p 80:80 --name my-reactapp-container prema07/dev-react-img:latest

elif [ "$BRANCH_NAME" = "master" ]; then
    echo "Pulling production image..."
    docker pull prema07/prod-react-img:latest
    echo "Starting production container..."
    docker run -d -p 80:80 --name my-reactapp-container prema07/prod-react-img:latest

else
    echo "Branch is neither dev nor main. Deployment aborted."
    exit 1
fi
