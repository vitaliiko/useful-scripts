## File operations

#### Merge files line-by-line
```
paste file1.txt file2.txt > fileresults.txt
```

#### Write line to a file
```
echo line > $file_name
```

#### Append line to a file
```
echo line >> $file_name
```

#### Merge files line by line and separate by semicolon
```
paste -d ';' file1.txt file2.txt > merge.txt
```

#### Remove 4th column from CSV file
```
cut -d, -f4 --complement input.csv > output.csv
```

#### Split file by multiple ones
```
split --additional-suffix=<suffix> --numeric-suffixes -n <count_of_files> <file_name> <output_file_prefix>
```

#### Split file by multiple ones with a sertain lines count
```
split --additional-suffix=<suffix> --numeric-suffixes -l <lines_count> <file_name> <output_file_prefix>
```

#### Split file by chunks that are not larger than 1MB without lines breaking
```
split --additional-suffix=.csv --numeric-suffixes -C 999000 <file_name>.csv <output_file_prefix>
```

#### Convert image from PNG into JPG
```
sudo apt-get install imagemagick
convert image.png image.jpg
```

#### Print first lines of all files without file names
```
head -n1 -q *.txt
```

#### Print column headers of all files but replace each separator with a new line
```
head -n1 -q *.dat | sed ':a;N;$!ba;s/\n/\n\n/g' | sed 's/|/\n/g' > columns.txt
```

#### Find lines from file1 which missing in file2
```
cat file1 | sort > file1_sorted
cat file2 | sort > file2_sorted
diff --new-line-format="" --unchanged-line-format="" file1_sorted file2_sorted
```

#### Display common lines in two sorted files
```
comm -12 file1.txt file2.txt
```

#### Display lines that are only in file1 but not in file2
```
comm -23 file1.txt file2.txt
```

#### Display lines that are only in file2 but not in file1
```
comm -13 file1.txt file2.txt
```

#### Replace spaces with underscore in names of multiple files or directories
```
find -name "* *" -type d | rename 's/ /_/g'
find -name "* *" -type f | rename 's/ /_/g'
```

#### Change column delimiters from `,` to `|` considering quotes
```
cat file.csv | perl -pe 's/,(?![\s])/|/g' > file.dat
```

#### Remove file header
```
cat input.txt | tail -n +2 > result.txt
```
