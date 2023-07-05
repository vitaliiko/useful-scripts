### k8s

#### Get resources
Get all pods, deployments and services:
```
kubectl get pods,svc,deploy
```

Get all resources:
```
kubectl get all
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

