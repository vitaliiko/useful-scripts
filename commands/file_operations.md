## File operations

### Add lines
Write line to a file
```bash
echo line > $file_name
```

Append line to a file
```bash
echo line >> $file_name
```

### Remove lines
Remove lines at the top
```bash
cat input.txt | tail -n +2 > result.txt
```

Remove lines at the bottom
```bash
cat input.txt | head -n -10 > result.txt
```

#### Statistic
Get unique set of lines
```bash
<input> | sort | uniq
or 
<input> | sort -u
```

Count non empty lines
```bash
<input> | sed '/^\s*$/d' | wc -l
```

Sort lines by amount of occurrences
```bash
cat ids.txt | sort | uniq -c | sort -r -g
```

Find rows with duplicates in first column
```bash
<input> | awk -F, '{print $1}' | sort | uniq -c | awk '{if ($1 > 1) print $1" "$2}' | sort -rg
```

### CSV
Remove 4th column from CSV file
```bash
cut -d, -f4 --complement input.csv > output.csv
```

Change column delimiters from `,` to `|` considering quotes
```bash
cat file.csv | perl -pe 's/,(?![\s])/|/g' > file.dat
```

Convert CSV to JSON
```bash
cat file.csv | python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))' > result.json
```

Convert CSV with specified delimiter to JSON
```bash
cat file.csv | python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin, delimiter="\t")]))' > result.json
```

### Split
Split file by multiple ones
```bash
split --additional-suffix=<suffix> --numeric-suffixes -n <count_of_files> <file_name> <output_file_prefix>
```

Split file by multiple ones with a sertain lines count
```bash
split --additional-suffix=<suffix> --numeric-suffixes -l <lines_count> <file_name> <output_file_prefix>
```

Split file by chunks that are not larger than 1MB without lines breaking
```bash
split --additional-suffix=.csv -d -C 1m input_file.csv output_file_
```

### Merge
Merge files line-by-line
```bash
paste file1.txt file2.txt > fileresults.txt
```

Merge files line by line and separate by semicolon
```bash
paste -d ';' file1.txt file2.txt > merge.txt
```

### Convert
Convert image from PNG into JPG
```bash
sudo apt-get install imagemagick
convert image.png image.jpg
```

Convert .mp3 into .flac
```bash
ffmpeg -i song.flac -ab 320k -map_metadata 0 -id3v2_version 3 song.mp3
```

### XLSX to CSV
To convert first sheet to csv
```bash
xlsx2csv input.xlsx > output.csv
```

To convert Nth sheet to csv
```bash
xlsx2csv input.xlsx -s N > output.csv
```

To convert all sheets and place them in a single csv file
```bash
xlsx2csv --all input.xlsx > output.csv
```

To convert all sheets and place them in separate csv files
```bash
xlsx2csv --all input.xlsx output_dir
```

### Print
Print first lines of all files without file names
```bash
head -n1 -q *.txt
```

Print column headers of all files but replace each separator with a new line
```bash
head -n1 -q *.dat | sed ':a;N;$!ba;s/\n/\n\n/g' | sed 's/|/\n/g' > columns.txt
```

Print lines of numbers in reverse order
```bash
<input> | sort -rn
```

### Compare
Find lines from file1 which missing in file2
```bash
cat file1 | sort > file1_sorted
cat file2 | sort > file2_sorted
diff --new-line-format="" --unchanged-line-format="" file1_sorted file2_sorted
```

Display common lines in two sorted files
```bash
comm -12 file1.txt file2.txt
```

Display lines that are only in file1 but not in file2
```bash
comm -23 file1.txt file2.txt
```

Display lines that are only in file2 but not in file1
```bash
comm -13 file1.txt file2.txt
```

### Misc
Recursively remove Windows related stuff from all files in directory
```
find . -type f -exec dos2unix {} \;
```
