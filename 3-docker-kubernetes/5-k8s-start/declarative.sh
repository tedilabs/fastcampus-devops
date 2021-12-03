#!/usr/bin/env sh

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Print grafana service url
minikube service grafana
