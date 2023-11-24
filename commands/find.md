## Find

Find all files with a certain extension in a directory recursively
```
find . -name '*.txt'
```

Exclude directories from file list
```
find . -maxdepth 1 -not -type d
```

Exec a command on each file
```
find . -type f -exec cat {} \;
or 
find . -type f -exec cat {} +
```

Replace all occurrences of a string in multiple files
```
find . -type f -exec sed -i 's/string_to_replace/new_string/g' {} \;
``` 

Rename all files or sub-directories in a particular directory to lowercase
```
find Documents -depth | xargs -n 1 rename -v 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
```

Delete all files within a directory except files matching pattern
```
find . -type f -not -name '*.gz' -print0 | xargs -0 -I {} rm -v {}
```
