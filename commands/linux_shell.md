## Commands

#### Port statistic
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

#### Copy file with scp
```
scp input.txt user@ip_adress:/home/user
```

#### Recursively send folder via ssh with excludings
```
rsync -rv -e "ssh -l user" --exclude 'node_modules' --exclude '*.log' ./folder ip_adress:/home/user
```

#### Get current date in a certain format
```
date '+%Y-%m-%d %H:%M:%S'
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

#### Use scp with password in a script
```
sshpass -p $password scp $source $destination
```
