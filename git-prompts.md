#### Git prompts in command line

To see Git prompts add the following lines to a `.bashrc` file:
```
export GIT_PS1_SHOWDIRTYSTATE='y'
export GIT_PS1_SHOWSTASHSTATE='y'
export GIT_PS1_SHOWUNTRACKEDFILES='y'
export GIT_PS1_DESCRIBE_STYLE='contains'
export GIT_PS1_SHOWUPSTREAM='auto'
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
```

To check PS1 value before this modification just use:
```
echo $PS1
```

Then use current PS1 value to add `\[\033[01;33m\]$(__git_ps1)` before `\[\033[00m\]\$`. This will add Git prompts without changes of existing format.
