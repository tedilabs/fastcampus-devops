#!/usr/bin/env sh

kubectl taint node minikube-m03 --overwrite role=system:NoSchedule
