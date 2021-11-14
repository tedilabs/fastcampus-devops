#!/usr/bin/env bash
## INFO: https://minikube.sigs.k8s.io/docs/start/

set -euf -o pipefail

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
