#### Replace first line with string
```
sed "1s=.*=String to be inserted=" original.txt > updated.txt
```

#### Remove first line of a file
```
sed '1d' $filename > $new_filename
```

#### Remove last line of a file
```
sed -i '$ d' $filename
```
