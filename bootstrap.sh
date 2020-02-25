#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo
echo "Deleting existing minikube cluster, if it exists..."
echo

minikube delete -p monitoring-the-jvm

echo
echo "Setting the Kube context to minikube..."
echo

kubectx minikube

K8s_VERSION=1.15.9

echo
echo "Creating minikube Kubernetes cluster on v${K8s_VERSION}..."
echo

minikube start -p monitoring-the-jvm --kubernetes-version=${K8s_VERSION} --cpus=8 --memory=4000mb

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
