#!/usr/bin/env bash

kubectl port-forward -n monitoring $(kubectl get pods --selector=app=prometheus -n monitoring --output=jsonpath="{.items..metadata.name}") 9090 > /dev/null 2>&1 &
kubectl port-forward -n monitoring $(kubectl get  pods --selector=app=grafana -n  monitoring --output=jsonpath="{.items..metadata.name}") 3000 > /dev/null 2>&1 &
kubectl port-forward -n monitoring $(kubectl get pods --selector=app=alertmanager -n monitoring --output=jsonpath="{.items..metadata.name}") 9093 > /dev/null 2>&1 &

sleep 5

open -na "Google Chrome" --args --new-window "http://localhost:9090/" "http://localhost:3000/" "http://localhost:9093/"

echo "Hit any key to finish..."
read 

kill %1; kill %2; kill %3
 