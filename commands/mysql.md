
#### Import data from one DB to another

```
mysqldump -u username -p"password" -R db_name > db_name.sql 
mysqladmin -u username -p"password" create new_db_name 
mysql -u username -p"password" new_db_name < db_name.sql 
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
