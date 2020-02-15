# Monitoring the JVM on Kubernetes

## Pre-requisites

Tools:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectx](https://github.com/ahmetb/kubectx)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [helm 2](https://github.com/helm/helm#install)

## Setup

_NOTE: these instructions have been tested on MacOS Catalina 10.5._

To bootstrap your minikube cluster simply run the `setup.sh` script.

This will enable the following capabilities:

- A Kubernetes cluster on v.1.15.9
- Helm 2
- Prometheus operator (via [helm](https://github.com/helm/charts/tree/master/stable/prometheus-operator))

## Expose the Prometheus services on your local host

We'll use [port-forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) to expose the services running on the cluster to your local machine.

The `port-forwading.sh` script will do this for us.

## Deploy an app

The application we will deploy is called `monkeynetes` and it is designed to simulate various failure scenarios.
