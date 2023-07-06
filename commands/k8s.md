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

#### Get a shell of a container 
```
kubectl exec -it podname -- /bin/bash
```

### Create/update resources

#### Craete pod
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

#### Update replica set
To scale replicas
```
kubectl scale --replicas=3 replicaset replicaset-name
```

To apply changes in replica set definition file
```
kubectl replace -f replicaset.yaml
```

#### Create deployment
```
kubectl create deployment mydeployment --replicas=3 --image=nginx
```

#### Create service
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

#### Switch namespace
```
kubectl config set-contenxt $(kubectl config current-context) --namespace=dev
```
