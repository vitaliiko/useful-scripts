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

#### Merge several files into one
```
awk 'FNR==1{print ""}{print}' *.xml > result.xml
```

#### Copy file with scp
```
scp input.txt user@ip_adress:/home/user
```

#### Recursively send folder via ssh with excludings
```
rsync -rv -e "ssh -l user" --exclude 'node_modules' --exclude '*.log' ./folder ip_adress:/home/user
```

### File conversion

#### Get all items between double quotes and write them with prefix to another file
```
cat input.txt | grep <expression> | awk -F'[""]' '{print "prefix" $4}' >> output.txt
```

## Aliases

Add

```
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`

```
alias dc='docker-compose'
```
