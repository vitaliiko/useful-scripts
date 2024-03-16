## AWK

### Filter

Filter lines matched a pattern
```bash
<input> | awk /cheese/
```

Filter lines where second field matched a pattern
```bash
<input> | awk '$2 ~ /cheese/'
```

Filter lines by pattern and prefix them with line number
```bash
<input> | awk '/cheese/ {print NR" "$0}'
```

Filter lines by value in a specified column
```bash
<input> | awk -F, '{if ($2 == "") print $1}'
```

Filter lines with empty value in a specifid column
```bash
<input> | awk -F, '{if ($2) print $1}'
```

### Conversions

Insert custom variable
```bash
awk -v variable="$value" '{print "prefix/"variable"/"$1}'
```

Split line by custom separator and print second field
```bash
awk -F<separator> '{print $2}' input.txt
or
awk -F'[<separator>]' '{print $2}' input.txt
or
awk 'BEGIN {FS="<separator>"} {print $2}' input.txt
```

Get all items between double quotes and write them with prefix to another file
```bash
cat input.txt | grep <expression> | awk -F'[""]' '{print "prefix" $4}' >> output.txt
```

Convert multiple lines into single line
```bash
cat input.txt | awk -F'[/]' '{print $1}' ORS="," > output.txt
```

Merge several files into one
```bash
awk 'FNR==1{print ""}{print}' *.xml > result.xml
```

Add prefix and suffix to each line in a file
```bash
<input> | awk '{print "preffix"$0"suffix"}'
```

Replace first word in each line
```bash
<input> | awk '{$1 = ""; print $0}' | sed 's/^ //g'
```

Add blank column to a file
```bash
awk -F, '$2="," $2' OFS=, <input>
```

Change date format from 31/01/2021 to 2021-01-31
```bash
input.dat | awk '
    BEGIN { FS = OFS = "|" } 
    { split($2, date, /\//)
      $2 = date[3] "-" date[2] "-" date[1]
      print $0 
    }
'
```

### Statistic

Count fields in each line
```bash
<input> | awk '{print NF}'
```

Count words 
```bash
<input> | awk '{word_count += NF} END {print word_count}'
```

Sort lines by length skipping empty ones
```bash
<input> | awk 'length > 0 {print length, $0}' | sort -n
```

