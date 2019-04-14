### S3

#### Upload file to bucket
```
aws s3api put-object --bucket ${bucket_name} --key ${object_name} --body ${file_name}
```

#### Get object modificaiton date
```
aws s3api head-object --bucket ${bucket_name} --key ${object_name} | grep LastModified | awk -F'[""]' '{print $4}'
```
or
```
$(aws s3 ls s3://${bucket_name} | grep ${object_name}) | awk '{print $1" "$2}'
```
