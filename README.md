# lakehouse_k8s_dev
Contains instructions and config files to deploy Lakehouse cluster on Kubernetes

## 1. Creating cluster

#export MINIKUBE_HOME=/data1/k8s
minikube start -p lakehouse-cluster-dev --memory 32768 --cpus 8

to check:
minikube ssh -p lakehouse-cluster-dev

### useful commands

kubectl get endpoints spark -n spark-dev

minikube -p lakehouse-cluster-dev image load alexmerced/spark35nb:latest

minikube -p lakehouse-cluster-dev image list | grep spark35nb

eval $(minikube -p lakehouse-cluster-dev docker-env)
docker pull alexmerced/spark35nb:latest

kubectl delete pod spark-f8fd87f4c-jbvth -n spark-dev --grace-period=0 --force
