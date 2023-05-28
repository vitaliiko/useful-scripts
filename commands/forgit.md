### Installation

1. Clone Git repo
```
git clone https://github.com/wfxr/forgit ~/.forgit
```
2. Add `forgit.plugin.zsh` to `.bashrc`
```
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh
```
3. Reload config file
```
source ~/.bashrc
```

### Usage
`ga` - interactive `git add` selector
`glo` - interactive `git log` viewer
`gi` - interactive .gitignore generator
`gd` - interactive `git diff` viewer
`grh` - interactive `git reset HEAD &lt;file>` selector
`gcf` - interactive `git checkout &lt;file>` selector
`gss` - interactive `git stash` viewer
`gclean` - interactive `git clean` selector
