#!/usr/bin/env sh

kubectl create deployment grafana --image=grafana/grafana --port=3000
kubectl expose deployment grafana --type=NodePort --port=80 --target-port=3000

# Print grafana service url
minikube service grafana
