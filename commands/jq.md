### JQ

#### To save curl output as a formatted JSON
```
curl localhost/resource | jq . > users.json 
```

#### To see ids of all users
```
cat users.json | jq '.users[] .id'
```

#### To convert users json into csv
```
jq -r '.users | map(.id), map(.name) | @csv' | csvtool transpose -
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
