
#### Import data from one DB to another
```
mysqldump -u username -p"password" -R db_name > db_name.sql 
mysqladmin -u username -p"password" create new_db_name 
mysql -u username -p"password" new_db_name < db_name.sql 
```

#### Back up and restore table
```
mysqldump -u username -p"password" -R db_name table_name > table_name.sql 
mysql -u username -p"password" db_name < table_name.sql 
```

#### Back up specific row from a table
```
mysqldump -u username -p db_name table_name --where="date_created='2013-06-25'" > few_rows_dump.sql
```

#### Import data from CSV file
```
LOAD DATA INFILE 'data.csv' INTO TABLE tableName FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
```
or 
```
mysqlimport -u user -p --fields-terminated-by=, dataBaseName tableName.csv
```

#### Run SQL query
```
mysql -u user -p -e 'show databases;'
```
