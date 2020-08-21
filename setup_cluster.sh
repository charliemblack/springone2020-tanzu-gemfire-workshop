#!/usr/bin/env bash

kind create cluster &

if [ ! -f geode-controller-0.0.1-beta1.tgz ]; then
    wget https://gemfire-field.s3.amazonaws.com/geode-controller-0.0.1-beta1.tgz &
fi
if [ ! -f geode-server-0.0.1-beta1.tgz ]; then
    wget https://gemfire-field.s3.amazonaws.com/geode-server-0.0.1-beta1.tgz &
fi
if [ ! -f geode-locator-0.0.1-beta1.tgz ]; then
    wget https://gemfire-field.s3.amazonaws.com/geode-locator-0.0.1-beta1.tgz &
fi
if [ ! -f geode-cluster-operator-0.0.1-beta1.tgz ]; then
    wget https://gemfire-field.s3.amazonaws.com/geode-cluster-operator-0.0.1-beta1.tgz &
fi

wait

kubectl cluster-info --context kind-kind

cat geode-controller-0.0.1-beta1.tar | docker import - registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-controller:0.0.1-beta1
cat geode-locator-0.0.1-beta1.tar | docker import - registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-locator:0.0.1-beta1
cat geode-server-0.0.1-beta1.tar | docker import - registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-server:0.0.1-beta1

kind load docker-image registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-controller:0.0.1-beta1
kind load docker-image registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-server:0.0.1-beta1
kind load docker-image registry.pivotal.io/tanzu-gemfire-for-kubernetes/geode-locator:0.0.1-beta1

kubectl create namespace gemfire-system
helm install geode-cluster-operator geode-cluster-operator-0.0.1-beta1.tgz --namespace gemfire-system
