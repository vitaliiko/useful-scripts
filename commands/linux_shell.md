## Commands

#### Port statistic
```
sudo netstat -lpn | grep :8080
```

#### Go to the script's home directory
```
cd ${0%/*} 
```

#### Replace spaces if names of multiple files or directories
```
find -name "* *" -type d | rename 's/ /_/g'
find -name "* *" -type f | rename 's/ /_/g'
```

#### Merge several files into one
```
awk 'FNR==1{print ""}{print}' *.xml > result.xml
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
