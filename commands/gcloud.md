## GCloud

### Cloud SDK installation
https://cloud.google.com/sdk/docs

#### Set up creds with environment variable
```
export GOOGLE_APPLICATION_CREDENTIALS=creds.json
```

#### Alternative ways to set up creds from JSON file on Windows

Find .boto file and configure it as follows:
```
[Credentials]
gs_service_key_file = /path/to/your/keyfile.json
```

Or set GOOGLE_APPLICATION_CREDENTIALS env var in PowerShell:
```
$env:GOOGLE_APPLICATION_CREDENTIALS="C:\...\keyfile.json"
```

#### Copy file from GCS to local machine
```
gsutil cp gs://bucket-name/file.txt target/directory
```

#### Remove file from GCS
```
gsutil rm gs://bucket-name/file.txt
```

#### List all files in path
```
gsutil ls -r gs://bucket-name/folder
```
