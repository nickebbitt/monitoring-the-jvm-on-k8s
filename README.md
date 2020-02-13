# Monitoring the JVM on Kubernetes with Prometheus

## Pre-requisites

Tools:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectx](https://github.com/ahmetb/kubectx)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [helm 2](https://github.com/helm/helm#install)

## Setup

To bootstrap your minikube cluster simply run the `setup.sh` script.

This will enable the following capabilities:

- A Kubernetes cluster on v.1.15.9
- Initialised with Helm 2
- Prometheus operator
- An application to simulate various failure scenarios aka `monkeynetes`

## Expose the services

We'll use [port-forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) to expose the services running on the cluster to your local machine. The `port-forwading.sh` script will do this for us.
