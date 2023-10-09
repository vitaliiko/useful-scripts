## Helm

To search for package
```
helm search repo "reponame"
```

To install package
```
helm install release-name bitnami/nginx
```

To install package adding suffixes to resource names
```
helm install bitnami/nginx --generate-name
```

To install package creating a new namespace
```
helm install nginx01 -n namespace bitnami/nginx --create-namespace
```

To update service port
```
helm upgrade nginx01 --set=service.port=8080 bitnami/nginx
```

To update release or install if it doesn't exist
```
helm upgrade --install nginx01 --set=service.port=8080 bitnami/nginx
```

To update release and wait until all pods are running successfully
```
helm upgrade nginx01 --set=service.port=8080 bitnami/nginx --wait --timeout 10s
```

To create an application
```
helm create app-name
```

To update dependencies
```
helm dependency update
helm dependency build .
```

### Custom package
To create a package
```
helm package --destination target-dir source-dir
helm repo index target-dir
```

To publish a package
```
helm repo add reponame http://repohost
``` 

To update repo
```
helm repo index target-dir
helm repo update 
```
