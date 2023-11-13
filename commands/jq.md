## JQ and YQ

### Parse JSON or YAML file
To see ids of all users
```
cat users.json | jq '.users[] .id'
```

To convert users JSON into CSV
```
jq -r '.users | map(.id), map(.name) | @csv' | csvtool transpose -
```

To convert YAML to JSON
```
yq -o=json users.yaml > users.json
```

To read JSON ignoring errors
```
cat users.json | jq -R "fromjson? | . "
```

#### Filtration
To find all inner objects where certain field's value:

Equals a string
```
cat users.json | jq '.users[] | select(.name == "Jack")'
```

Not equals a string
```
cat users.json | jq '.users[] | select(.name != "Jack")'
```

Ends with a string
```
cat users.json | jq '.users[] | select(.address.street // "" | endswith("ave"))'
```
// "" is to provide empty string as a default value

Matches regex
```
cat users.json | jq '.users[] | select(.name | match("pattern"))'
```

Matches multiple conditions
```
cat users.json | jq '.users[] | select((.address.country == "US") and (.age > 25))'
```

To find all inner objects where certain field does not exist
```
cat users.json | jq '.users[] | select(has("address") | not)'
```

#### Statistic
To count occurrences of a values in a certain field
```
cat users.json | jq '.users[] | select(.age > 25).name' | sort | uniq -c | sort -r -g
```

#### Users JSON
```
{
  "users": [
    {
      "id": 1,
      "name": "John",
      "age": 30,
      "address": {
        "country": "US"
      }
    },
    {
      "id": 2,
      "name": "Jack",
      "age": 29
    }
  ]
}
```

### CURL
To save curl output as a formatted JSON
```
curl localhost/resource | jq . > users.json 
```

### JWT
To parse JWT
```
echo <JWT> | jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson'
jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< <JWT>
```
