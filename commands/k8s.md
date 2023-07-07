### k8s

[kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

#### Get resources
Get all pods, deployments and services:
```
kubectl get pods,svc,deploy
```

Get all resources in a specific namespace:
```
kubectl get all -n=space
```

Get all resources in all namespaces:
```
kubectl get all -A
```

Get resource with labels
```
kubectl get pods --show-labels
```

Describe resource:
```
kubectl describe pod podname
```

#### Namespace
To switch default namespace
```
kubectl config set-contenxt $(kubectl config current-context) --namespace=dev
```

#### Get a shell of a container 
```
kubectl exec -it podname -- /bin/bash
```

### Create/update resources

#### Pod
```
kubectl run nginx --image nginx
kubectl run nginx --image nginx --labels=tier=fe
```

To crate a pod and write its definition into a file
```
kubectl run nginx --image nginx --dry-run=client -o yaml > pod.yaml
```

To edit created pod
```
kubectl edit pod nginx
```

To delete running pod and create a new one instead
```
kubectl replace --forse -f pod.yaml
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
```
kubectl create deployment mydeployment --replicas=3 --image=nginx
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

#### ConfigMap
To create config map
```
kubectl create cm app-config --from-literal=APP_PROP=value
kubectl create cm app-config --from-file=app.properties
```

#### Secret
To create secret
```
kubectl create secret generic app-secret --from-literal=APP_PROP=value
kubectl create secret generic app-secret --from-file=app.properties
```
