#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0` && pwd)
echo $SCRIPT_DIR

TTNAMESPACE=$(kubectl get namespaces | grep -op 'technical-test')

if [ -z $TTNAMESPACE ]; then
    echo "techinal-test namespace doesn't exist, creating it..."
    kubectl create -f $SCRIPT_DIR/technical-test-namespace.yaml
    kubectl config set-context tech-test --namespace=technical-test --cluster=docker-desktop --user=docker-desktop
else
    echo $TTNAMESPACE exists
fi

kubectl config use-context tech-test

# Deploy service and deployment
kubectl apply -f $SCRIPT_DIR/nodeapi-service.yaml -f $SCRIPT_DIR/nodeapi-deployment.yaml