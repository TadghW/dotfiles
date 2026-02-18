### TadghVim 

#### Currently installed:

 - LazyVim (Plugin Manager)
 - AlphaVim (Greeter)
 - NeoTree (Buffer and Filesystem Tree)
 - Telescope (Fuzzy find files and strings)

##### To use:
 
 MODES:
 - i for insert mode to the left
 - a for insert mode to the right
 - v for visual mode
 - V for visual mode (line, includes indent)
 - escape to leave any mode

 MOVEMENT:
 - h is left
 - j is down
 - k is up
 - l is right
 - w goes back a word
 - b goes back a word
 - $ goes to the end of a sentence
 - " goes to the beginning of a sentence
 
 ACTIONS:
 - d is delete (dd for a line, dw for the next word, compunding allowed such as d3j, d2w, etc).
 - c is cut
 - y is yank (copy)
 - these commands should be combined with a movement for selection - dd or cc with grab a line, dw or cw the next work - you can add in numbers and directions in combinations like d3j or d2w)
 - u is undo
 - ctrl + r is redo

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

 - why do deletes go to clipboard? if there's no good reason to learn I'd like to delete it
 - I feel as though the font could be more readable (what are the meta fonts? Roboto mono, IBM Plex Mono, Cousine, Azeret Mono all nice)
 - neotree symbols are currently all question marks, should fix that (icon pack?)
 - might be worth experimenting with more colour schemes (this one's just ok, legible but heavy)
 - I should install and try nvimbegood
 - nvim eats modifiers so moving between panes in tmux now sucks (prefix + h,j,k,l), I should figure out how to better integrate my environments - ideally with unified schemes per env that don't clash 
 - I should look for a better way to name tmux tabs (nvim report directories?)
 - I should get into the habit of opening nvim in different tabs based rather than multiple tabs in nvim
 - I need to figure out how to loop nvim into LSPs

