# Monitoring the JVM on Kubernetes

## Pre-requisites

Tools:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectx](https://github.com/ahmetb/kubectx)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- [helm 2](https://github.com/helm/helm#install)

## Setup

_NOTE: these instructions have been tested on MacOS Catalina 10.5._

To bootstrap your `minikube` cluster simply run the `bootstrap.sh` script.

This will enable the following capabilities:

- A Kubernetes cluster on v.1.15.9
- Helm 2
- Prometheus operator (via [helm](https://github.com/helm/charts/tree/master/stable/prometheus-operator))

## Expose the Prometheus services on your local host

We'll use [port-forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) to expose the services running on the cluster to your local machine.

The `port-forwading.sh` script will do this for us.

## Deploy an app

The application we will deploy is called [Chaos Kraken](https://github.com/autotraderuk/chaos-kraken) and it is designed to simulate various failure scenarios.

[Chaos Kraken](https://github.com/autotraderuk/chaos-kraken) is an open source project created at [Auto Trader UK](https://careers.autotrader.co.uk/). It is used to test and validate various behaviours of their Kubernetes based delivery platform.

```bash
./deploy-chaos-kraken.sh
```

## Troubleshooting

### Check your prometheus config

```bash
kubectl -n monitoring get secret prometheus-prometheus-prometheus-oper-prometheus -ojson | jq -r '.data["prometheus.yaml.gz"]' | base64 -d | gunzip
```

### Grafana username & password

The username & password for Grafana are stored in a secret:

```bash
kubectk get secret -n monitoring prometheus-grafana -ojson | jq -r '.data["admin-user"]' | base64 -d
kubectl get secret -n monitoring prometheus-grafana -ojson | jq -r '.data["admin-password"]' | base64 -d
```

The defaults are `admin/prom-operator` and as we are running this locally via Minikube we won't worry about making it more secure.
