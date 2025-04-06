#!/bin/bash
#docker-compose up
echo " Deployment Branch : $BRANCH_NAME"
docker stop my-reactapp-container || true
docker rm my-reactapp-container || true
if [ "$BRANCH_NAME" = "dev" ] ; then
    docker pull prema07/dev-react-img:latest
    docker run -d -p 80:80 --name my-reactapp-container prema07/dev-react-img:latest
elif [ "$BRANCH_NAME" = "main" ]; then
    docker pull prema07/prod-react-img:latest
    docker run -d -p 80:80 --name my-reactapp-container prema07/prod-react-img:latest
fi