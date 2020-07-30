### S3

#### Upload file to S3
```
aws s3api put-object --bucket ${bucket_name} --key ${object_name} --body ${file_name}
```
or 
```
aws s3 cp <path_on_local_machine> s3://<bucket_name>/<path_to_file>
```

#### Download file from S3
```
aws s3 cp s3://<bucket_name>/<path_to_file> <path_on_local_machine>
```

#### Sync files with S3. This will upload missed or updated files to a bucket:
```
aws s3 sync /some-folder s3://bucket-name/folder
```

#### Get object modificaiton date
```
aws s3api head-object --bucket ${bucket_name} --key ${object_name} | grep LastModified | awk -F'[""]' '{print $4}'
```
or
```
$(aws s3 ls s3://${bucket_name} | grep ${object_name}) | awk '{print $1" "$2}'
```

### EC2
#### Get public IP address of an instace
```
aws ec2 describe-instances --instance-ids <ID> | grep PublicIpAddress | awk -F'"' '{print $4}'
```
