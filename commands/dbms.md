## DBMS

### MySQL

Import data from one DB to another
```sql
mysqldump -u username -p"password" -R db_name > db_name.sql 
mysqladmin -u username -p"password" create new_db_name 
mysql -u username -p"password" new_db_name < db_name.sql 
```

Back up and restore table
```sql
mysqldump -u username -p"password" -R db_name table_name > table_name.sql 
mysql -u username -p"password" db_name < table_name.sql 
```

Back up specific row from a table
```sql
mysqldump -u username -p db_name table_name --where="date_created='2013-06-25'" > few_rows_dump.sql
```

Import data from CSV file
```sql
LOAD DATA INFILE 'data.csv' INTO TABLE tableName FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
```
or 
```sql
mysqlimport -u user -p --fields-terminated-by=, dataBaseName tableName.csv
```

Run SQL query
```sql
mysql -u user -p -e 'show databases;'
```

### PostgreSQL

Find database by name
```sql
SELECT datname FROM pg_catalog.pg_database WHERE datname = '?';
```

Get database activity info
```sql
SELECT * FROM pg_stat_activity WHERE datname = '?';
```

Get size of a table
```sql
SELECT pg_size_pretty( pg_total_relation_size('table_name') );
```

Get size of all tables in a schema
```sql
SELECT table_schema, table_name, pg_size_pretty(pg_relation_size(quote_ident(table_name)))
FROM information_schema.tables
WHERE table_schema = 'public'
```

Kill all connections to the DB
```sql
SELECT pg_terminate_backend(pg_stat_activity.pid) 
FROM pg_stat_activity 
WHERE pg_stat_activity.datname = '?' AND pid <> pg_backend_pid();
```

Drop database if exists
```sql
DROP DATABASE IF EXISTS ?;
```
