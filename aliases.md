## Aliases

Add

```bash
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`

#### Aliases for this cheat-sheet
```bash
alias harango='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/arangodb.md'  
alias hawk='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/awk.md'  
alias haws='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/aws_cli.md'  
alias hcron='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/crontab.md'  
alias hcurl='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/curl.md'  
alias hdb='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/dbms.md'  
alias hdocker='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/docker.md'  
alias hfile='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/file_operations.md'  
alias hfind='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/find.md'  
alias hgc='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gcloud.md'  
alias hgit='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/git.md'  
alias hgpg='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gpg.md'  
alias hgradle='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gradle.md'  
alias hgrep='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/grep.md'  
alias hgzip='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gzip.md'  
alias hjq='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/jq.md'  
alias hkube='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/kubectl.md'  
alias minik='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/minikube.md'  
alias hsh='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/linux_shell.md'  
alias hpower='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/power_shell.md'  
alias hsed='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/sed.md'  
alias hssh='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/ssh.md'  
alias htar='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/tar.md'  
alias hwget='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/wget.md'  
alias hxargs='glow https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/xargs.md'  
```

[How to install glow](https://github.com/charmbracelet/glow)

#### Useful aliases

```bash
alias dc='docker-compose'
alias tempo='git add . && git commit -m "Tempo commit"'  
alias dkill='docker kill $(docker ps -q)'
alias g='git'
alias k='kubectl'
alias gc='gcloud'
alias runftp='systemctl start vsftpd.service'
```


#### Git aliases
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
git config --global alias.aj "add *.java"  
```  
Add to `[alias]` section of `.gitconfig` file:  
```bash
ri = "!ri() { git rebase -i HEAD~$1; }; ri" // interactively rebase N last commits   
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
