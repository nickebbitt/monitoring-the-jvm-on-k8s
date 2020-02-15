#!/bin/bash

echo
echo "Building monkeynetes Docker image in minikube..."
echo

eval $(minikube docker-env)

docker-compose build

echo 
echo "Deploy monkeynetes Helm chart..."
echo
helm install monkeynetes/helm --name monkeynetes  --wait 
