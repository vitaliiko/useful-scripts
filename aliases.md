## Aliases

Add

```bash
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`


### Useful aliases

```bash
alias dc='docker-compose'
alias tempo='git add . && git commit -m "Tempo commit"'  
alias dkill='docker kill $(docker ps -q)'
alias g='git'
alias k='kubectl'
alias gc='gcloud'
alias runftp='systemctl start vsftpd.service'
```

### Git aliases
```bash
git config --global alias.co checkout  
git config --global alias.br branch  
git config --global alias.cm commit  
git config --global alias.st status  
git config --global alias.cp cherry-pick  
  
git config --global alias.ll "log --oneline --decorate" 
git config --global alias.amend "commit --amend"  
git config --global alias.append "commit --amend --no-edit"  
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"  
git config --global alias.last 'log -1 HEAD'  
git config --global alias.who "shortlog -n -s --no-merges"  
git config --global alias.undo "reset HEAD~1"  
git config --global alias.undom = "reset --hard HEAD~1"  
git config --global alias.force "push --force-with-lease --force-if-includes"  
```  
Add to `[alias]` section of `.gitconfig` file:  
```bash
ri = "!f() { git rebase -i HEAD~$1; }; f" // interactively rebase N last commits   
la = "!f() { git config -l | grep alias | cut -c 7-; }; f" // show list of aliases 
nb = "!f() { git checkout -b feature/$1; }; f" // create new branch and checkout to it 
fpush = "!f() { git push -u origin $(git rev-parse --abbrev-ref HEAD); }; f" // push current branch for the first time 
clean = "!f() { git branch --merged | grep -v '*' | xargs git branch -D; }; f" // remove all merged branches except current one 
```

### Windows
For Windows aliases could be added to `C://Users/username/.bash_profile` file.

To use Sublime Text in Git Shell:
```bash
alias subl="/c/Program\ Files/Sublime\ Text/sublime_text.exe"
```
