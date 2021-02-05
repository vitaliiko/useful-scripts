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

#### Download directory from S3
```
aws s3 cp s3://<bucket_name>/<path_to_dir> <path_on_local_machine> --recursive
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

#### List files in a bucket
```
aws s3 ls s3://mybucket --recursive --human-readable --summarize
```

#### Delete multiple files
```
echo files_to_remove.txt | xargs -n1 aws s3 rm
```

#### Get name of latest uploaded file to a bucket
```
aws s3 ls s3://bucket-name/folder --recursive | sort | tail -n 1 | awk '{print $4}'
```

### EC2
#### Get public instace IP address
```
aws ec2 describe-instances --instance-ids <ID> | grep PublicIpAddress | awk -F'"' '{print $4}'
```

#### Get public instance DNS
```
aws ec2 describe-instances --instance-ids <ID> | grep PublicDnsName | head -n 1 | awk -F'"' '{print $4}'
```

#### See information about Security group
```
aws ec2 describe-security-groups --group-name launch-wizard-1
```

#### Set Security group rule for access via SSH
```
aws ec2 authorize-security-group-ingress \
    --group-name launch-wizard-1 \
    --protocol tcp \
    --port 22 \
    --cidr <IP_address>/32
```

#### Remove Security group rule by IP
```
aws ec2 revoke-security-group-ingress \
        --group-name launch-wizard-1 \
        --protocol tcp \
        --port 22 \
        --cidr <IP_address>
```

#### Add description for an existing Security group rule by IP
```
aws ec2 update-security-group-rule-descriptions-ingress \
    --group-id sg-123abc12 \
    --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "203.0.113.0/16", "Description": "SSH access from ABC office"}]}]'
```

### Athena

#### Execute query
```
aws athena start-query-execution --query-string "${query}" --result-configuration OutputLocation=s3://$execution_result_path/
```
