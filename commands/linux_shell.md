## Commands

#### Find open porst in the system
```
netstat -tulpn
netstat -tlpn # Just TCP ports
netstat -ulpn # Just UDP ports
```

#### Specific port check
```
sudo netstat -lpn | grep :8080
```

#### Go to the script's home directory
```
cd ${0%/*} 
```

#### Replace spaces with underscore in names of multiple files or directories
```
find -name "* *" -type d | rename 's/ /_/g'
find -name "* *" -type f | rename 's/ /_/g'
```

#### Get current date in a certain format
```
date '+%Y-%m-%d %H:%M:%S'
```

#### Get uniq set of lines
```
<input> | sort | uniq
or 
<input> | sort -u
```

#### Count non empty lines
```
<input> | sed '/^\s*$/d' | wc -l
```

#### Sort lines of numbers in reverse order
```
<input> | sort -rn
```

#### Kill all processes with a certain name
```
ps aux | awk '/<app>/ {print $2}' | xargs kill
```

#### Print IP address of a domain
```
dig +short google.com
```

#### Print my public IP address
```
dig +short myip.opendns.com @resolver1.opendns.com
```
or
```
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```

### File conversion

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

#### Uppercase string
```
string=some text
echo ${string^^}
```
