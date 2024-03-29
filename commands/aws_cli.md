## AWS CLI

### S3

Create a bucket
```bash
aws s3 mb s3://bucketname
```

Upload file to S3
```bash
aws s3api put-object --bucket ${bucket_name} --key ${object_name} --body ${file_name}
```
or 
```bash
aws s3 cp <path_on_local_machine> s3://<bucket_name>/<path_to_file>
```

Download file from S3
```bash
aws s3 cp s3://<bucket_name>/<path_to_file> <path_on_local_machine>
```

Download directory from S3
```bash
aws s3 cp s3://<bucket_name>/<path_to_dir> <path_on_local_machine> --recursive
```

Sync files with S3. This will upload missed or updated files to a bucket:
```bash
aws s3 sync /some-folder s3://bucket-name/folder
```

Set the website configuration for a bucket
```bash
aws s3 website s3://bucketname --index-document index.html --error-document error.html
```

Get object's modification date
```bash
aws s3api head-object --bucket ${bucket_name} --key ${object_name} | grep LastModified | awk -F'[""]' '{print $4}'
```
or
```bash
$(aws s3 ls s3://${bucket_name} | grep ${object_name}) | awk '{print $1" "$2}'
```

List files in a bucket
```bash
aws s3 ls s3://mybucket --recursive --human-readable --summarize
```

Delete multiple files
```bash
echo files_to_remove.txt | xargs -n1 aws s3 rm
```

Get name of latest uploaded file to a bucket
```bash
aws s3 ls s3://bucket-name/folder --recursive | sort | tail -n 1 | awk '{print $4}'
```

Update bucket's policy
```bash
aws s3api put-bucket-policy --bucket bucketname --policy file://policy.json
```

### EC2

Start/stop instance and check its status
```bash
aws ec2 start-instances --instance-ids $instanceId
aws ec2 stop-instances --instance-ids $instanceId
aws ec2 describe-instance-status --instance-ids $instanceId
```

Get public IP address of an instance
```bash
aws ec2 describe-instances --instance-ids <ID> | grep PublicIpAddress | awk -F'"' '{print $4}'
```

Get public instance DNS
```bash
aws ec2 describe-instances --instance-ids <ID> | grep PublicDnsName | head -n 1 | awk -F'"' '{print $4}'
```

See information about Security group
```bash
aws ec2 describe-security-groups --group-name launch-wizard-1
```

Set Security group rule for access via SSH
```bash
aws ec2 authorize-security-group-ingress \
    --group-name launch-wizard-1 \
    --protocol tcp \
    --port 22 \
    --cidr <IP_address>/32
```

Remove Security group rule by IP
```bash
aws ec2 revoke-security-group-ingress \
        --group-name launch-wizard-1 \
        --protocol tcp \
        --port 22 \
        --cidr <IP_address>
```

Add description for an existing Security group rule by IP
```bash
aws ec2 update-security-group-rule-descriptions-ingress \
    --group-id sg-123abc12 \
    --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "203.0.113.0/16", "Description": "SSH access from ABC office"}]}]'
```

### Athena

Execute query
```bash
aws athena start-query-execution --query-string "${query}" --result-configuration OutputLocation=s3://$execution_result_path/
```
