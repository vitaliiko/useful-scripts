## Aliases

Add

```
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`

#### Useful aliases

```
alias dc='docker-compose'
alias tempo='git add . && git commit -m "Tempo commit"'  
alias dkill='docker kill $(docker ps -q)'
alias g='git'
```


#### Git aliases
```
git config --global alias.co checkout  
git config --global alias.br branch  
git config --global alias.cm commit  
git config --global alias.st status  
  
git config --global alias.ll "log --oneline --decorate" 
git config --global alias.po "push origin"  
git config --global alias.pos "pull origin staging"  
git config --global alias.amend "commit --amend"  
git config --global alias.append "commit --amend --no-edit"  
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"  
git config --global alias.last 'log -1 HEAD'  
git config --global alias.who "shortlog -n -s --no-merges"  
git config --global alias.undo "reset HEAD~1"  
```  
Add to `.gitconfig`  
```
ri = "!ri() { git rebase -i HEAD~$1; }; ri"  
la = "!git config -l | grep alias | cut -c 7-"  
```

### Windows
For Windows aliases could be added to `C://Users/username/.bash_profile` file.

To use Sublime Text in Git Shell:
```
alias subl="/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe"
```
