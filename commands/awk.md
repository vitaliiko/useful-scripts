#### Get all items between double quotes and write them with prefix to another file
```
cat input.txt | grep <expression> | awk -F'[""]' '{print "prefix" $4}' >> output.txt
```

#### Convert multiple lines into single line
```
cat input.txt | awk -F'[/]' '{print $1}' ORS="," > output.txt
```

#### Merge several files into one
```
awk 'FNR==1{print ""}{print}' *.xml > result.xml
```

