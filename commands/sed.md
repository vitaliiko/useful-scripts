## Sed

### Replace strings
Replace first line with string
```bash
sed "1 s/.*/String to be inserted/" file.txt
```

Replace first line with string and write to the input file
```bash
sed -i "1 s/.*/String to be inserted/" file.txt
```

Replace first line with string and write to the input file saving backup
```bash
sed -i'.bkp' "1 s/.*/String to be inserted/" file.txt
```

Replace string with the other one
```bash
sed s/string_to_replace/new_string/g file.txt
```

Replace string with URL
```bash
sed s,placeholder,http://example.com,g file.txt
```

Replace multiple strings with the other one
```bash
sed s/\(string1\|string2\)/new_string/g file.txt
```

Fully replace line started with
```bash
sed -i -e "s/\bstring[^ ]*/replacement/g" file.txt
```

Just remove all occurrences of a string
```bash
sed s/"string_to_replace"//g file.txt
```

Replace new line symbol
```bash
sed ':a;N;$!ba;s/\n/ /g' file.txt
```

Replace CRLF with LF
```bash
sed -i $'s/\r$//' file.txt
```

### Remove lines
Remove first line of a file
```bash
sed '1d' $filename > $new_filename
```

Remove first line of a file and rewrite original file
```bash
sed -i '1d' $filename
```

Remove last line of a file
```bash
sed -i '$ d' $filename 
```

Remove first and last lines of a file at once
```bash
sed -i '1d;$d' $filename
```

### Insert lines
Append line before the first one
```bash
sed -i '1 i\new_line' $filename
```

Insert line after the match
```bash
sed '/^key=.*/a after=value' file.txt
```

Insert line before the match
```bash
sed '/^key=.*/i before=value' file.txt
```

Insert multiple lines after the match
```bash
sed '/^key=.*/i before1=value\nbefore2=value' file.txt
```

### Modify lines
Append each line with a string ignoring empty lines
```bash
sed -r '/^\s*$/d' file.txt | sed 's/^/string/' > result.txt
```

Uppercase text
```bash
sed 's/[a-z]/\U&/g'
```

Lowercase text
```bash
sed 's/[A-Z]/\L&/g'
```

Prepend file with word
```bash
sed -i 1s/^/word/ file.txt
```
