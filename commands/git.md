## Git

### Checkout
Checkout to previous branch
```bash
git checkout -
```

### Get commit info
Get last commit hash (first 7 characters)
```bash
git rev-parse HEAD | head -c 7
```

Get first commit hash
```bash
git rev-list --max-parents=0 HEAD
```

Get first commit
```bash
git log $(git rev-list --max-parents=0 HEAD)
```

### Edit commits
Change commit author
```bash
git commit --amend --author="Author Name <email@address.com>"
```

Do rebase but keep original commit date
```bash
git rebase -i --committer-date-is-author-date hash
```

Remove files from commit
```bash
git reset --soft HEAD~1 
git checkout file.txt 
git commit
```

Force push but preventing overwrites
```
git push --force-with-lease --force-if-includes
```

### Move commits
Move last N commits to a new branch
```bash
git branch newbranch  
git reset --hard HEAD~3  
git checkout newbranch  
```

Move commits from one branch to another one (!! considering chronological order)
```bash
git checkout branch-B
git cherry-pick hash1
git cherry-pick hash2
```

Push to another branch
```bash
git push origin branch1:branch2  
git push origin "branch with new changes":"branch you are pushing to"  
```

### Untracked files
#### Remove untracked files and directories
First, check which files will be removed
```bash
git clean -d -n
```

Then remove
```bash
git clean -d -f
```

#### Remove untracked and ignored files and directories
```bash
git clean -d -f -x
```

Remove only ignored files and directories
```bash
git clean -d -f -X
```

Restore deleted not committed files
```bash
git checkout HEAD <filename>
```

### Undo something
Undo git stash pop that results in merge conflict
```bash
git reset HEAD .
git stash
```

Revert merge commit
```bash
git revert -m 1 <commit-hash>
```

Undo merge commit
```bash
git reset --hard HEAD~1
```

Undo anything even rebase
```bash
git reflog
git reset --hard HEAD@{N}
```

### Clean up
Remove all merged branches except current one
```bash
git branch --merged | grep -v '*' | xargs git branch -D
```

Remove all branches except specified ones
```bash
git branch | grep -vE 'master|prod|staging' | xargs git branch -D
```

### Patch
To create patch with not committed changes
```bash
git diff > changes.patch
```

To create patch with changes in specified files
```bash
git diff -- file1 file2 > changes.patch
```

To create patch based on a specified commit
```bash
git diff <commit_hash> > changes.patch
```

To create patch with changes between commits
```bash
git diff <commit_hash_1> <commit_hash_2> > changes.patch
```

To add new files so they are visible in diff
```
git add -N <file_name>
```

To apply patch
```bash
git apply changes.patch
```

Check if a patch is applicable
```bash
git apply --check changes.patch
```

### Remote branches
Merge remote branch into current one
```bash
git fetch origin aRemoteBranch
git merge origin/aRemoteBranch
```

Restore file version from remote branch
```bash
git checkout origin/master -- path/to/file
```

### Look for specified changes
Show all commits with a specified file
```bash
git log --all -- "<full_file_path>"
```

Show all commits with a file name pattern
```bash
git log --all -- "*filename*"
```

Show commit where a file was added
```bash
git log --diff-filter=A -- "*filename*"
```

Show commit where a file was deleted
```bash
git log --diff-filter=D -- "*filename*"
```

Show commit changes
```bash
git show <commit_hash>
```

### Misc
Change file permissions and add this change to index (for Windows)
```bash
git update-index --chmod=+x gradlew
```

Count of commits by author
```bash
git shortlog -s -n --all --no-merges
```

### Configuration
Use git remote with other SSH port
```bash
git remote add origin ssh://user@host:1234/path/to/git
```

Set git user
```
git config user.name "username"
git config user.email "email@email"
```

Set git user globally
```
git config --global user.name "username"
git config --global user.email "email@email"
```

Use Sublime as a default editor
```bash
git config --global core.editor "subl -n -w"
```
for Windows
```bash
git config --global core.editor "'C:/Program Files/Sublime Text 3/sublime_text.exe' -w"
```
