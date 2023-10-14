## Sed

#### Replace first line with string
```
sed -i "1 s/.*/String to be inserted/" file.txt
```

#### Remove first line of a file
```
sed '1d' $filename > $new_filename
```

#### Remove first line of a file and rewrite original file
```
sed -i '1d' $filename
```

#### Remove last line of a file
```
sed -i '$ d' $filename 
```

#### Remove first and last lines of a file at once
```
sed -i '1d;$d' $filename
```

#### Append line before the first one
```
sed -i '1 i\new_line' $filename
```

#### Replace occurrences of a string
```
sed s/"string_to_replace"//g file.txt
```

#### Replace string with the other one
```
sed s/string_to_replace/new_string/g file.txt
```

#### Replace string with URL
```
sed s,placeholder,http://example.com,g file.txt
```

#### Insert line after the match
```
sed '/^key=.*/a after=value' file.txt
```

#### Insert line before the match
```
sed '/^key=.*/i before=value' file.txt
```

#### Insert multiple lines after the match
```
sed '/^key=.*/i before1=value\nbefore2=value' file.txt
```

#### Append each line with a string ignoring empty lines
```
sed -r '/^\s*$/d' file.txt | sed 's/^/string/' > result.txt
```

#### Replace new line
```
sed ':a;N;$!ba;s/\n/ /g' file.txt
```

#### Uppercase text
```
sed 's/[a-z]/\U&/g'
```

#### Lowercase text
```
sed 's/[A-Z]/\L&/g'
```

#### Prepend file with word
```
sed -i 1s/^/word/ file.txt
```

#### Replace CRLF with LF
```
sed -i $'s/\r$//' file.txt
```
