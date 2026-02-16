### TadghVim 

#### Currently installed:

 - LazyVim (Plugin Manager)
 - AlphaVim (Greeter)
 - NeoTree (Buffer and Filesystem Tree)
 - Telescope (Fuzzy find files and strings)

##### To use:

 - Leader is space
 - Leader + e opens a filesystem tree
 - Leader + b opens a buffer list
 - Leader + tab moves between windows
 - Leader + ff to fuzzy-find by filename
 - Leader + fg to fuzzy-find by string

###### Project navigation:

_As a workaround to get me going with nvim I'm using neovim's tab system and :tcd to have different neovim workspaces. This is redundant as tmux has its own session and workspace organisation features which I would probably be better off leveraging. What's stopping me is a combination of habit and that my tmux tabs are named after whatever program is running, so I end up with a lot of nvim | nvim | nvim | - which is hard to keep track of. I should investigate a better solution for slotting these things together_

 - :tabnew to create a new tab
 - :tabnext to cycle between tabs
 - :tcd to change the directory context of a tab
 - :e + filename will create that file on write

##### To do & Fixes:

 - nvim eats modifiers so moving between panes in tmux now sucks (prefix + h,j,k,l), I should figure out how other people solve this - ideally landing on a caps or control modifier 
 - I should look for a better way to name tmux tabs (nvim report directories?)
 - I should get into the habit of opening nvim in different tabs based rather than multiple tabs in nvim
 - I need to figure out how to loop nvim into LSPs

