## JQ and YQ

### Parse JSON or YAML file
To see ids of all users
```bash
cat users.json | jq '.users[] .id'
```

To convert users JSON into CSV
```bash
jq -r '.users | map(.id), map(.name) | @csv' | csvtool transpose -
```

To convert YAML to JSON
```bash
yq -o=json users.yaml > users.json
```

To read JSON ignoring errors
```bash
cat users.json | jq -R "fromjson? | . "
```

#### Filtration
To find all inner objects where certain field's value:

Equals a string
```bash
cat users.json | jq '.users[] | select(.name == "Jack")'
```

Not equals a string
```bash
cat users.json | jq '.users[] | select(.name != "Jack")'
```

Ends with a string
```bash
cat users.json | jq '.users[] | select(.address.street // "" | endswith("ave"))'
```
// "" is to provide empty string as a default value

Matches regex
```bash
cat users.json | jq '.users[] | select(.name | match("pattern"))'
```

Matches multiple conditions
```bash
cat users.json | jq '.users[] | select((.address.country == "US") and (.age > 25))'
```

To find all inner objects where certain field does not exist
```bash
cat users.json | jq '.users[] | select(has("address") | not)'
```

#### Statistic
To count occurrences of a values in a certain field
```bash
cat users.json | jq '.users[] | select(.age > 25).name' | sort | uniq -c | sort -r -g
```

#### Users JSON
```json
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
```bash
curl localhost/resource | jq . > users.json 
```

### JWT
To parse JWT
```bash
echo <JWT> | jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson'
jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< <JWT>
```
