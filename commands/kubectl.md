## kubectl

[Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

[Kubectl Reference Docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-strong-getting-started-strong-)

[Kubernetes API Reference Docs](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/)

### Get resources
To get all pods, deployments and services
```
kubectl get pods,svc,deploy
```

To get all resources in a specific namespace
```
kubectl get all -n=space
```

To get all resources in all namespaces
```
kubectl get all -A
```

To get resource with labels and watch for changes
```
kubectl get pods --show-labels --watch
or
watch kubectl get pods --show-labels
```

To describe resource
```
kubectl describe pod podname
```

To get pod definition
```
kubectl get pod podname -o yaml > pod.yaml
```

To see info about a resource
```
kubectl explain <resource>
```

### Settings overview
To view all k8s resources, their short names and versions
```
kubectl api-resources
```

To view k8s default config
```
kubectl config view
```

To view contexts
```
kubectl config get-contexts
```

To view kube API server settings
```
kubectl describe pod kube-apiserver-controlplane -n kube-system
```

To view arguments a kube-apiserver is running with
```
ps -ef | grep kube-apiserver
```
or
```
kubectl exec -it kube-apiserver-controlplane -n kube-system -- kube-apiserver -h  
```

To check kube-apiserver status
```
kubectl get pod -n kube-system
```

### Search for resources
To get pods which are in prod or in dev envs
```
kubectl get pods --selector env=prod --selector env=dev
```

To get all resource related to prod env and frontend
```
kubectl get all --selector env=prod,tier=frontend
```

To count resources
```
kubectl get pods --selector env=prod --no-headers | wc -l
```

### Context & Namespace
To set default context
```
kubectl config use-context dev
```

To set default context from non-default kube config
```
kubectl config use-context dev --konfigfile=/path/config
```

To set default namespace
```
kubectl config set-context contextname --namespace=dev
kubectl config set-context --current --namespace=dev
```

### Monitoring
To see CPU and memory consumption by pods
```
kubectl top pod
```

To get definitions for metrics service
```
 git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
```

### Inside a container
To get a shell of a container 
```
kubectl exec -it podname -- /bin/bash
```

To get a current user of a container
```
kubectl exec podname -- whoami
```

To get a list of container's environment variables
```
kubectl exec podname -- printenv
```

To copy files to container
```
kubectl cp /source_folder/file.txt podname:target_folder/ -c containername
```

To copy files from container
```
kubectl cp podname:sourece_folder/file.txt /target_folder -c containername
```

### Pod / container logs
Get current logs of a pod
```
kubectl logs nginx
```

Get logs of previous terminated nginx container from pod web-1
```
kubectl logs -p -c nginx web-1
```

Stream logs of nginx container from pod web-1
```
kubectl logs -f -c nginx web-1
```

Display only the most recent 20 lines of logs
```
kubectl logs --tail=20 nginx
```

Show all logs from pod nginx written in the last hour
```
kubectl logs --since=1h nginx
```

Job logs
```
kubectl logs job.batch/job-name
```

### Create/update resources

#### Pod
```
kubectl run nginx --image nginx
kubectl run nginx --image nginx --labels=tier=fe
kubectl run nginx --image nginx -l tier=fe
```

To crate a pod and write its definition into a file
```
kubectl run nginx --image nginx --dry-run=client -o yaml > pod.yaml
```

To edit created pod
```
kubectl edit pod nginx
```

To get a definition of existing pod
```
kubectl get pod nginx -o yaml > pod.yaml
```

To delete running pod and re-create it with an updated definition
```
kubectl replace --force -f pod.yaml
```

To delete all pods with a label
```
kubectl delete pod -l label=value
```

#### ReplicaSet
To scale replicas
```
kubectl scale --replicas=3 replicaset replicaset-name
```

To apply changes in replica set definition file
```
kubectl replace -f replicaset.yaml
```

#### Deployment
To create a deployment
```
kubectl create deployment mydeployment --replicas=3 --image=nginx
```

To change deployment's image
```
kubectl set image deployment mydeploy container-name=image:latest
```

To scale deployment
```
kubectl scale --replicas=3 deployment deployment-name
```

To rollback changes
```
kubectl rollout undo deployment mydeploy
```

To see deployment status and history
```
kubectl rollout status deployment mydeploy
kubectl rollout history deployment mydeploy
```

To add a label
```
kubectl label deploy deployname key=value
```

#### Job
To create a job
```
kubectl create job --image=imagename
```

#### Service
```
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml > service.yaml
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml > service.yaml
```

To create service with selectors
```
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml > service.yaml
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml > service.yaml
```

To create a pod with a service
```
kubectl run nginx --image nginx --port=80 --expose=true
```

#### Ingress
To create ingress
```
kubectl create ingress ingress-name --rule="host/path=service:port"
```

#### ConfigMap
To create config map
```
kubectl create cm app-config --from-literal=APP_PROP=value
kubectl create cm app-config --from-file=app.properties
```

#### Secret
To create secret
```
kubectl create secret generic app-secret --from-literal=APP_PROP_1=value1 --from-literal=APP_PROP_2=value2
kubectl create secret generic app-secret --from-file=app.properties
```

To create a TLS secret
```
kubectl create secret tls tls-secret --cert=/path/tls.crt --key=/path/tls.key
```

To create Docker repository secret
```
kubectl create secret docker-registry secret-name --docker-server=https://index.docker.io/v1/ --docker-username=username --docker-password=password --docker-email=email@email.com
```

#### ServiceAccount
To create service account
```
kubectl create sa service-account-name
```

To assign a token to a service account
```
kubectl create token service-account-name
```

#### Node
To create a taint
```
kubectl taint node nodename app=appname:NoSchedule
```

To remove a taint
```
kubectl taint node nodename app=appname:NoSchedule-
```

To add a label
```
kubectl label node nodename key=value
```

To make node unschedulable
```
kubectl cordon nodename
```

To make node schedulable again
```
kubectl uncordon nodename
```

To copy files to node
```
scp /folder/* nodename:/folder
```

### Check Access
```
kubectl auth can-i create deployments
kubectl auth can-i delete nodes
kubectl auth can-i create pods --as username
kubectl auth can-i create pods --as username --namespace test
```

### Kube API
To start Kube proxy
```
kubectl proxy 8001&
```

Then to get a list of all available APIs
```
curl http://localhost:8001/apis
```

To get list of resources in core API group
```
curl http://localhost:8001/api/v1
```

To get all resources in named API groups
```
curl http://localhost:8001/apis/apps/v1
```