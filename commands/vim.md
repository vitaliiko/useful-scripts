## Vim

### Normal mode

`G` – Go to the last line of the file  
`gg` – Go to the first line of the file  
`$` – Go to the end of line  
`0` (zero) – Go to the beginning of line  
`w` – Jump by start of words  
`W` – Jump by words (spaces separate words)  
`b` – Jump backward by words  
`B` – Jump backward by words (spaces separate words)  
`PgDn Key` – Move down page-wise  
`PgUp Key` – Move up page-wise  
`Ctrl+d` – Move half-page down  
`Ctrl+u` – Move half-page up  

### Insert mode

#### Insert a text

`i` – Insert before the cursor  
`a` – Insert after the cursor  
`I` – Insert at the beginning of the line, this is useful when you are in the middle of the line.  
`A` – Insert at the end of the line  
`o` – Open a new line below the current line  
`O` – Append a new line above the current line  
`ea` – Insert at the end of the word  

#### Copy, Paste and Delete a Line

`yy` – yank (copy) a line  
`p/P` – Paste after cursor/ put before cursor  
`dd` – delete a line  
`dw` – delete the word  

#### Search and Replace Pattern

`/pattern` – To search a given pattern  
`?pattern` – To search backward a given pattern  
`n` – To repeat search  
`N` – To repeat backward search  
`:%s/old-pattern/new-pattern/g` – Replace all old formats with the new format across the file  
`:s/old-pattern/new-pattern/g` – Replace all old formats with the new format in the current line  
`:%s/old-pattern/new-pattern/gc` – Replace all old formats with the new format across the file with confirmations  

#### Undo/Redo/Repeat

`u` – Undo the changes  
`Ctrl+r` – Redo the changes  
`.` – Repeat last command  

#### Saving and Exiting

`:w` – Save the changes but don’t exit  
`:wq` – Write and quit  
`:q!` – Force quit  
