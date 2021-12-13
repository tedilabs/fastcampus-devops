#!/usr/bin/env sh

kubectl create namespace a
kubectl create namespace b
kubectl apply -f . -n a
kubectl apply -f . -n b
