#### Find files with specific word inside with specific extension
```
grep -r "word" . --include=*.txt
```

#### Exclude lines matched expression
```
cat $FILE_NAME | grep -v "word"
```

#### Find lines matched multiple expressions
```
cat $FILE_NAME | grep -E "expression1|expression2"
```

#### Display line number near matchings
```
cat $FILE_NAME | grep -n "expression"
```

