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
