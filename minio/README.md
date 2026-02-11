# minio
The instalation of minio with statefulset is based on https://github.com/minio/minio/issues/6775
Persistence: https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes/
Stateful set, headless service, and service needs to be deployed.
To know why headless-service is needed, https://stackoverflow.com/questions/52707840/what-is-a-headless-service-what-does-it-do-accomplish-and-what-are-some-legiti

