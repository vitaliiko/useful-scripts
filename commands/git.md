#### Remove all merged branches except current one
```
git branch --merged | grep -v '*' | xargs git branch -D
```

#### Move last N commits to a new branch
```
git branch newbranch  
git reset --hard HEAD~3  
git checkout newbranch  
```

#### Move commits from one branth to another one (!! considering chronological order)
```
git checkout branch-B
git cherry-pick hash1
git cherry-pick hash2
```

#### Push to another branch
```
git push origin branch1:branch2  
git push origin "branch with new changes":"branch you are pushing to"  
```

#### Count of commits by author
```
git shortlog -s -n --all --no-merges
```

#### Get last commit hash (first 7 characters)
```
git rev-parse HEAD | head -c 7
```

#### Use Sublime as a default editor
```
git config --global core.editor "subl -n -w"
```
for Windows
```
git config --global core.editor "'C:/Program Files/Sublime Text 3/sublime_text.exe' -w"
```
