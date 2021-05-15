## Aliases

Add

```
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi
```

into `.bashrc` and perform `source ~/.bashrc` after each edit of `.bash_aliases`

#### Aliases for this cheat-sheet
alias harango='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/arangodb.md'  
alias hawk='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/awk.md'  
alias haws='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/aws_cli.md'  
alias hcron='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/crontab.md'  
alias hcurl='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/curl.md'  
alias hdocker='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/docker.md'  
alias hgcloud='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gcloud.md'  
alias hgit='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/git.md'  
alias hgpg='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gpg.md'  
alias hgrep='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/grep.md'  
alias hgzip='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/gzip.md'  
alias hjq='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/jq.md'  
alias hsh='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/linux_shell.md'  
alias hmysql='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/mysql.md'  
alias hsed='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/sed.md'  
alias hssh='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/ssh.md'  
alias htar='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/tar.md'  
alias hwget='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/wget.md'  
alias hxargs='curl https://raw.githubusercontent.com/vitaliykobrin/useful-scripts/master/commands/xargs.md'  


#### Useful aliases

```
alias dc='docker-compose'
alias tempo='git add . && git commit -m "Tempo commit"'  
alias dkill='docker kill $(docker ps -q)'
alias g='git'
alias runftp='systemctl start vsftpd.service'
```


#### Git aliases
```
git config --global alias.co checkout  
git config --global alias.br branch  
git config --global alias.cm commit  
git config --global alias.st status  
git config --global alias.cp cherry-pick  
  
git config --global alias.ll "log --oneline --decorate" 
git config --global alias.po "push origin"  
git config --global alias.pos "pull origin staging"  
git config --global alias.amend "commit --amend"  
git config --global alias.append "commit --amend --no-edit"  
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"  
git config --global alias.last 'log -1 HEAD'  
git config --global alias.who "shortlog -n -s --no-merges"  
git config --global alias.undo "reset HEAD~1"  
git config --global alias.aj "add *.java"
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
