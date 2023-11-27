## Helm

### New app set up

To create an application
```bash
helm create app-name
```

To install dependencies
```bash
helm dependency update .
```

To build dependencies (fill charts/ folder with all packages listed in lock file)
```bash
helm dependency build .
```

### Install and upgrade

To search for package
```bash
helm search repo "reponame"
```

To install package
```bash
helm install release-name package-name
e.g.
helm install nginx01 bitnami/nginx
helm install myappname .
```

To install package adding suffixes to resource names
```bash
helm install bitnami/nginx --generate-name
```

To install package creating a new namespace
```bash
helm install nginx01 -n namespace bitnami/nginx --create-namespace
```

To update package using custom value
```bash
helm upgrade nginx01 --set=service.port=8080 bitnami/nginx
```

To install package using custom values file
```bash
helm install nginx01 --values values.yaml bitnami/nginx
```

To use dry-run and print all charts
```bash
helm install nginx01 --values values.yaml --dry-run bitnami/nginx
```

To update release or install if it doesn't exist
```bash
helm upgrade --install nginx01 bitnami/nginx
```

To update release and wait until all pods are running successfully
```bash
helm upgrade nginx01 bitnami/nginx --wait --timeout 10s
```

### History and rollback

To view release history
```bash
helm history release-name
```

To do rollback to one of the previous revisions
```bash
helm rollback release-name revision-number
e.g.
helm rollback nginx01 1
```

To uninstall release but keep its history
```bash
helm uninstall release-name --keep-history
```

To recover uninstalled release
```bash
helm rollback release-name uninstalled-revision-number
```

### Custom package

To create a package
```bash
helm package --destination target-dir source-dir
helm repo index target-dir
```

To publish a package
```bash
helm repo add reponame http://repohost
``` 

To update repo
```bash
helm repo index target-dir
helm repo update 
```
