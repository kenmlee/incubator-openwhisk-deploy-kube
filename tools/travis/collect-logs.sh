#!/bin/bash

set -x

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../../"

cd $ROOTDIR

echo "Gathering logs to upload to https://app.box.com/v/openwhisk-travis-logs"

mkdir logs

# Logs from all the pods
kubectl -n openwhisk logs -lname=couchdb >& logs/couchdb.log
kubectl -n openwhisk logs -lname=zookeeper >& logs/zookeeper.log
kubectl -n openwhisk logs -lname=kafka >& logs/kafka.log
kubectl -n openwhisk logs controller-0 >& logs/controller-0.log
kubectl -n openwhisk logs controller-1 >& logs/controller-1.log
kubectl -n openwhisk logs -lname=invoker >& logs/invoker.log
kubectl -n openwhisk logs -lname=nginx >& logs/nginx.log
kubectl get pods --all-namespaces -o wide --show-all >& logs/all-pods.txt

# System level logs from minikube
minikube logs >& logs/minikube.log
