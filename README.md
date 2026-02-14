# Deploying Lakehouse (Minio + Nessie + Trino + Postgres + Spark) on Kubernetes
Contains instructions and config files to deploy Lakehouse cluster on Kubernetes

## 1. Cluster creation

```
export MINIKUBE_HOME=/data1/k8s  # optional
minikube start -p lakehouse-cluster-dev --memory 32768 --cpus 8
minikube addons -p lakehouse-cluster-dev enable ingress 
minikube addons -p lakehouse-cluster-dev enable ingress-dns
minikube addons -p lakehouse-cluster-dev enable storage-provisioner
```

Checking:
```
minikube ssh -p lakehouse-cluster-dev
minikube profile list --detailed
kubectl config current-context
```

Tunnel creation:
```
minikube tunnel -p lakehouse-cluster-dev
```

## 2. Minio

```
cd minio

kubectl create namespace minio-dev

kubectl apply -f minio-pv.yaml -n minio-dev
kubectl apply -f minio-pvclaim.yaml -n minio-dev
```

```
echo -n 'minio123' | base64
kubectl apply -f minio-secret.yaml -n minio-dev
```

```
kubectl apply -f minio-sts.yaml -n minio-dev
kubectl apply -f minio-headless-service.yaml -n minio-dev
kubectl apply -f minio-service.yaml -n minio-dev
```

```
kubectl get pv
kubectl get pvc -n minio-dev
kubectl get all -n minio-dev
kubectl get pods -n minio-dev
kubectl describe statefulset -n minio-dev
kubectl describe pod minio-0 -n minio-dev
kubectl get svc -n minio-dev
```

### To open miniuo web - interface:
```
http://10.106.91.195:6543/login
minio
minio123
```
### In the UI, create bucket called **iceberg**

## 3. Postgres
cd psql_simple

kubectl create namespace psql-dev

echo -n 'postgres' | base64 
out: cG9zdGdyZXM=
echo -n 'admin123' | base64
out: YWRtaW4xMjM=

kubectl create secret generic postgres-secret --from-literal=POSTGRES_PASSWORD=postgres -n psql-dev
//or
//kubectl apply -n psql-dev -f psql-secret.yaml

checking:
kubectl get secrets -n psql-dev
kubectl describe secret postgres-secret -n psql-dev

kubectl apply -n psql-dev -f psql-pv.yaml
kubectl apply -n psql-dev -f psql-pvclaim.yaml 
kubectl get pv
kubectl get pvc -n psql-dev

kubectl apply -n psql-dev -f statefulset.yaml
kubectl apply -n psql-dev -f service.yaml
[kubectl apply -n psql-dev -f service_alt.yaml]
[kubectl get nodes -o wide]
[and we can connect to postgres by node ip and port in service_alt.yaml]
  
kubectl get all -n psql-dev
kubectl get pvc -n psql-dev
kubectl get pods -n psql-dev
kubectl get services -n psql-dev

//to create client - pod and connect to db nessie:
kubectl run -i --tty --rm psql-client --image=postgres:16-alpine -n psql-dev --env="PGPASSWORD=postgres" --command -- psql -h postgres -U postgres -d nessie

--pgadmin---
kubectl apply -n psql-dev  -f pgadmin-secret.yaml
kubectl apply -n psql-dev  -f pgadmin-deployment.yaml
kubectl apply -n psql-dev  -f pgadmin-service.yaml

kubectl get svc -n psql-dev

http://10.111.152.222:5432

user admin@admin.com
pass admin123
postgres.psql-dev.svc.cluster.local
db postgres
user postgres
pass postgres


## 4. Nessie

Create the namespace
```
kubectl create namespace nessie-dev
```

Apply the secret
```
kubectl apply -f nessie-secret.yaml -n nessie-dev
```

Create PV and PVC (optional because the nessie will use postgresql as version store)
```
kubectl apply -n nessie-dev -f nessie-pv.yaml
kubectl apply -n nessie-dev -f nessie-pvclaim.yaml
kubectl get pv
kubectl get pvc -n nessie-dev
```

Deploy Nessie
```
kubectl apply -n nessie-dev -f nessie-deployment.yaml
kubectl apply -n nessie-dev -f nessie-service.yaml
```

Check and troubleshoot
```
kubectl get deployments -n nessie-dev
kubectl get pods -n nessie-dev -o wide
kubectl get svc -n nessie-dev
kubectl get all -n nessie-dev
```

Access nessie UI
```
http://10.102.200.61:6788
```


## 5. Spark
cd spark



## Appendix
### useful commands

kubectl get endpoints spark -n spark-dev

minikube -p lakehouse-cluster-dev image load alexmerced/spark35nb:latest

minikube -p lakehouse-cluster-dev image list | grep spark35nb

eval $(minikube -p lakehouse-cluster-dev docker-env)
docker pull alexmerced/spark35nb:latest

kubectl delete namespace spark-dev
kubectl delete pod spark-f8fd87f4c-jbvth -n spark-dev --grace-period=0 --force
kubectl delete pv nessie-volume -n nessie-dev --grace-period=0 --force

echo "127.0.0.1 minio.kubernetes.net" | sudo tee -a /etc/hosts

