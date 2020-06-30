### Cloud SDK installation
https://cloud.google.com/sdk/docs

### Set up creds from JSON file
```
gcloud auth activate-service-account --key-file=creds.json
```

### Set up creds for Google Cloud Storage tool from JSON file
```
gsutil config -е creds.json
```

### Copy file from GCS to local machine
```
gsutil cp gs://bucket-name/file.txt .
```

### Remove file from GCS
```
gsutil rm gs://bucket-name/file.txt
```

### List all files in path
```
gsutil ls -r gs://bucket-name/folder
```
