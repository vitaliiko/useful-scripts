## Helm

### New app set up

To create an application
```
helm create app-name
```

To install dependencies
```
helm dependency update .
```

### Install and upgrade

To search for package
```
helm search repo "reponame"
```

To install package
```
helm install release-name package-name
e.g.
helm install nginx01 bitnami/nginx
helm install myappname .
```

To install package adding suffixes to resource names
```
helm install bitnami/nginx --generate-name
```

To install package creating a new namespace
```
helm install nginx01 -n namespace bitnami/nginx --create-namespace
```

To update package using custom value
```
helm upgrade nginx01 --set=service.port=8080 bitnami/nginx
```

To install package using custom values file
```
helm install nginx01 --values values.yaml bitnami/nginx
```

To use dry-run and print all charts
```
helm install nginx01 --values values.yaml --dry-run bitnami/nginx
```

To update release or install if it doesn't exist
```
helm upgrade --install nginx01 bitnami/nginx
```

To update release and wait until all pods are running successfully
```
helm upgrade nginx01 bitnami/nginx --wait --timeout 10s
```

### History and rollback

To view release history
```
helm history release-name
```

To rollback to one of the previous revisions
```
helm rollback release-name revision-number
e.g.
helm rollback nginx01 1
```

To uninstall release but keep its history
```
helm uninstall release-name --keep-history
```

To recover uninstalled release
```
helm rollback release-name uninstalled-revision-number
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
