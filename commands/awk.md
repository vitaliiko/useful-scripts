#### Split line by custom separator and print second field
```
awk -F<separator> '{print $2}' input.txt
or
awk -F'[<separator>]' '{print $2}' input.txt
or
awk 'BEGIN {FS="<separator>"} {print $2}' input.txt
```

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

#### Find lines matched a pettern
```
<input> | awk /cheese/
```

#### Find lines where second field matched a pattern
```
<input> | awk '$2 ~ /cheese/'
```

#### Add preffix and suffix to each line in a file
```
<input> | awk '{print "preffix"$0"suffix"}'
```

#### Print lines matched pattern and prefix them with line number
```
<input> | awk '/cheese/ {print NR" "$0}'
```

#### Print count of fields in each line
```
<input> | awk '{print NF}'
```

#### Count words 
```
<input> | awk '{word_count += NF} END {print word_count}'
```

#### Sort lines by length skipping empty ones
```
<input> | awk 'length > 0 {print length, $0}' | sort -n
```

#### Replace first word in each line
```
<input> | awk '{$1 = ""; print $0}' | sed 's/^ //g'
```

#### Add blank column to a file
```
awk -F, '$2="," $2' OFS=, <input>
```

