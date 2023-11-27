## Grep

Find files with specific word inside with specific extension
```bash
grep -r "word" . --include=*.txt
```

Exclude lines matched expression
```bash
cat $FILE_NAME | grep -v "word"
```

Find lines matched multiple expressions
```bash
cat $FILE_NAME | grep -E "expression1|expression2"
```

Display line number near matchings
```bash
cat $FILE_NAME | grep -n "expression"
```

Display N lines before and after the match
```bash
cat $FILE_NAME | grep -B N -A N "word"
```
