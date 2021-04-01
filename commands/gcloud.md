### Cloud SDK installation
https://cloud.google.com/sdk/docs

#### Set up creds from JSON file
```
gcloud auth activate-service-account --key-file=creds.json
```

#### Set up creds for Google Cloud Storage tool from JSON file
```
gsutil config -е creds.json
```

#### Alternative ways to set up creds from JSON file on Windows

Find .boto file and configure it as follows:
```
[Credentials]
gs_service_key_file = /path/to/your/keyfile.json
```

Or set GOOGLE_APPLICATION_CREDENTIALS env var in PowerShell:
```
$env:GOOGLE_APPLICATION_CREDENTIALS=/path/to/your/keyfile.json
```

#### Copy file from GCS to local machine
```
gsutil cp gs://bucket-name/file.txt .
```

#### Remove file from GCS
```
gsutil rm gs://bucket-name/file.txt
```

#### List all files in path
```
gsutil ls -r gs://bucket-name/folder
```
