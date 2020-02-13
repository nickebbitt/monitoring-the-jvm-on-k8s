#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo
echo "Setting the Kube context to minikube..."
echo

kubectx minikube

K8s_VERSION=1.15.9

echo
echo "Creating minikube Kubernetes cluster on v${K8s_VERSION}..."
echo

minikube start --kubernetes-version=${K8s_VERSION}

echo
echo "Initialising Helm..."
echo
helm init --wait

echo
echo "Deploying the prometheus operator Helm chart..."
echo
helm install --name prometheus --namespace monitoring stable/prometheus-operator --wait
