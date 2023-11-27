## Find

Find all files with a certain extension in a directory recursively
```bash
find . -name '*.txt'
```

Exclude directories from file list
```bash
find . -maxdepth 1 -not -type d
```

Exec a command on each file
```bash
find . -type f -exec cat {} \;
or 
find . -type f -exec cat {} +
```

Replace all occurrences of a string in multiple files
```bash
find . -type f -exec sed -i 's/string_to_replace/new_string/g' {} \;
``` 

Rename all files or sub-directories in a particular directory to lowercase
```bash
find Documents -depth | xargs -n 1 rename -v 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
```

Delete all files within a directory except files matching pattern
```bash
find . -type f -not -name '*.gz' -print0 | xargs -0 -I {} rm -v {}
```

Replace spaces with underscore in names of multiple files or directories
```bash
find -name "* *" -type d | rename 's/ /_/g'
find -name "* *" -type f | rename 's/ /_/g'
```
