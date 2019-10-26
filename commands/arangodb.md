### ArangoDB

#### Import data from tsv file
```
arangoimport --server.database "<database>" --file "<file name>" --type tsv --collection "collection" --on-duplicate "ignore"
```

#### Create dump
```
arangodump --server.username <user_name> --server.password <password> --server.database <db_name> --output-directory "<target_directory>"
```

#### Restore dump
```
arangorestore --server.username <user_name> --server.password <password> --server.database <db_name> --create-database true --input-directory "<dump_location>"
```
