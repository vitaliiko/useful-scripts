#### Call xargs for all outputs one by one
```
cat file_with_argumantes.txt | xargs -n1 echo
```

#### Rename all files or subdirectories in a particular directory to lowercase
```
find Documnets -depth | xargs -n 1 rename -v 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
```

#### Delete all files within a directory except one or few files with a given extension
```
find . -type f -not -name '*gz' -print0 | xargs -0 -I {} rm -v {}
```

#### Call defined function in xargs
```
showword() {
  echo $1
}

export -f showword
echo This is a sample message | xargs bash -c 'showword "$@"'
```
