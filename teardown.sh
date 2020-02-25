#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo
echo "Deleting minikube cluster..."
echo
minikube delete
