#!/usr/bin/env sh

kubectl label node minikube --overwrite team=green
kubectl label node minikube-m02 --overwrite team=red
kubectl label node minikube-m03 --overwrite team=red
