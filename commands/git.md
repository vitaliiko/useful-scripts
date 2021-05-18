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

#### Undo git stash pop that results in merge conflict
```
git reset HEAD .
git stash
```

#### Revert merge commit
```
git revert -m 1 <commit-hash>
```
or
```
git reset --hard HEAD~1
```

#### Create patch
To create patch with not commited chages
```
git diff > changes.patch
```
To create patch with changes in specified files
```
git diff -- file1 file2 > changes.patch
```
To create patch based on a scpecified commit
```
git diff <commit_hash> > changes.patch
```
To create patch with changes between commits
```
git diff <commit_hash_1> <commit_hash_2> > changes.patch
```

#### Apply patch
```
git apply changes.patch
```

#### Check if a patch is applicable
```
git apply --check changes.patch
```

#### Use Sublime as a default editor
```
git config --global core.editor "subl -n -w"
```
for Windows
```
git config --global core.editor "'C:/Program Files/Sublime Text 3/sublime_text.exe' -w"
```

#### Remove untracked files and directories
First, check which files will be removed
```
git clean -d -n
```
Then remove
```
git clean -d -f
```

#### Remove untracked and ignored files and directories
```
git clean -d -f -x
```

#### Remove only ignored files and directories
```
git clean -d -f -X
```

#### Restore deleted not commited files
```
git checkout HEAD <filename>
```

#### Use git remote with other SSH port
```
git remote add origin ssh://user@host:1234/path/to/git
```

#### Merge remote branch into current one
```
git fetch origin aRemoteBranch
git merge origin/aRemoteBranch
```

