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
