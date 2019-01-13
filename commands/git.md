#### Remove all merged branches except current one
git branch --merged | grep -v '*' | xargs git branch -D

#### Move last N commits to a new branch
git branch newbranch  
git reset --hard HEAD~3  
git checkout newbranch  

#### Push to another branch
git push origin branch1:branch2  
git push origin "branch with new changes":"branch you are pushing to"  

#### Count of commits by author
git shortlog -s -n --all --no-merges

#### Get last commit hash (first 7 characters)
git rev-parse HEAD | head -c 7

#### Use Sublime as a default editor
git config --global core.editor "subl -n -w"

#### Aliases

git config --global alias.co checkout  
git config --global alias.br branch  
git config --global alias.cm commit  
git config --global alias.st status  
  
git config --global alias.ll "log --oneline --decorate" 
git config --global alias.pos "pull origin staging"  
git config --global alias.amend "commit --amend"  
git config --global alias.append "commit --amend --no-edit"  
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"  
git config --global alias.last 'log -1 HEAD'  
git config --global alias.who "shortlog -n -s --no-merges"  
  
Add to `.gitconfig`  
ri = "!ri() { git rebase -i HEAD~$1; }; ri"  
la = "!git config -l | grep alias | cut -c 7-"  
