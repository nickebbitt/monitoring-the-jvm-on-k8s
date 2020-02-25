#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo
echo "Deleting existing minikube cluster, if it exists..."
echo
minikube delete

echo
echo "Creating minikube Kubernetes cluster..."
echo
minikube start --kubernetes-version=1.15.9 --cpus=8 --memory=4000mb
kubectx minikube

echo
echo "Pre-cache some of the Docker images we'll need..."
echo
eval $(minikube docker-env)
docker pull gradle:jdk11
docker pull adoptopenjdk/openjdk11

echo
echo "Initialising Helm..."
echo
helm init --wait

echo
echo "Deploying the prometheus operator Helm chart..."
echo
helm install --name prometheus --namespace monitoring stable/prometheus-operator --wait

echo
echo "Hit any key to deploy the Chaos Kraken..."
read 
./deploy-chaos-kraken.sh

echo
echo "Hit any key to install custom prometheus config for JVM metrics..."
read 
kubectl -n monitoring apply -f prometheus/servicemonitor.yaml 
kubectl -n monitoring apply -f prometheus/prometheusrule.yaml
kubectl -n monitoring apply -f prometheus/jvm-metrics-configmap.yaml 
