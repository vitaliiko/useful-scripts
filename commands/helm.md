## Helm

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
