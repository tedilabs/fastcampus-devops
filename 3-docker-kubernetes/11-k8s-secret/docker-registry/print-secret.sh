#!/usr/bin/env sh

kubectl create secret docker-registry docker-registry \
  --docker-username=fastcampus \
  --docker-password=fastcampus \
  --dry-run -o yaml
