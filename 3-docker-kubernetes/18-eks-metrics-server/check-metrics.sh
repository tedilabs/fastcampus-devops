#!/usr/bin/env sh


# 노드 메트릭 확인
kubectl top node

# kube-system 네임스페이스의 파드 메트릭 확인
kubectl top pod -n kube-system

# 모든 네임스페이스의 파드 메트릭 확인
kubectl top pod --all-namespaces
