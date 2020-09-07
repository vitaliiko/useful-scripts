### ArangoDB

#### Import data from tsv file
```
arangoimport \
        --server.database "<database>" \
        --file "<file name>" \
        --type tsv \
        --collection "collection" \
        --on-duplicate "ignore"
```

#### Create dump
```
arangodump \
        --server.username <user_name> \
        --server.password <password> \
        --server.database <db_name> \
        --output-directory "<target_directory>"
```

#### Restore dump
```
arangorestore \
        --server.username <user_name> \
        --server.password <password> \
        --server.database <db_name> \
        --create-database true \
        --input-directory "<dump_location>"
```

#### Run ArangoDB with minimum resources consumption
```
arangod --log.level queries=debug \
        --server.descriptors-minimum 128 \
        --rocksdb.max-total-wal-size 1024000 \
        --rocksdb.write-buffer-size 2048000 \
        --rocksdb.max-write-buffer-number 2 \
        --rocksdb.total-write-buffer-size 81920000 \
        --rocksdb.dynamic-level-bytes false \
        --rocksdb.block-cache-size 2560000 \
        --rocksdb.enforce-block-cache-size-limit true
```
