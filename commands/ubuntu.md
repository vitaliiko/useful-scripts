#### Port statistic
sudo netstat -lpn | grep :8080

### Aliases

Add

```
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`

alias dc='docker-compose'
