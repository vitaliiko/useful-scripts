
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