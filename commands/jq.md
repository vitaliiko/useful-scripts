### JQ and YQ

#### To save curl output as a formatted JSON
```
curl localhost/resource | jq . > users.json 
```

#### To see ids of all users
```
cat users.json | jq '.users[] .id'
```

#### To convert users JSON into CSV
```
jq -r '.users | map(.id), map(.name) | @csv' | csvtool transpose -
```

#### To convert YAML to JSON
```
yq -o=json users.yaml > users.json
```

### Users JSON
```
{
  "users": [
    {
      "id": 1,
      "name": "John"
    },
    {
      "id": 2,
      "name": "Jack"
    }
  ]
}
```

### JWT
To parse JWT
```
echo <JWT> | jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson'
jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< <JWT>
```
