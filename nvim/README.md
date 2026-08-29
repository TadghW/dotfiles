### TadghVim 

#### Currently installed:

 - LazyVim (Plugin Manager)
 - AlphaVim (Greeter) -- Kinda redundant? Cool, but I never really see it. Just keeping around in case the workflow I land on benefits from it
 - NeoTree (Buffer and Filesystem Tree)
 - Telescope (Fuzzy find files and strings)
 - Nerd Fonts (Install a font with devicons and set it as terminal default - nerd-fonts has a good selection - I'm using JetBrainsMono; Firacode and Roboto Mono are also nice.)
 - Catppuccin 
 - Lualine
 - render-markdown.nvim (draws markdown in the buffer instead of just highlighting it)
 - snacks.nvim (only the `zen` and `dim` modules are switched on)

##### Prose mode (.md and .txt):

_Opening a `.md` or `.txt` file switches into a writing setup: soft wrap at word boundaries, no line numbers or sign column, British-English spell check, softened prose colours, and markdown rendered in place. Zen mode opens automatically and centres the text in an 84-column window._

 - Leader + z toggles Zen mode by hand
 - Leader + Z zooms the current window to fullscreen (no centring)
 - Leader + mz turns auto-Zen on/off for the rest of the session
 - Leader + mr toggles markdown rendering for this buffer (to see the raw text)
 - Leader + ms toggles spell check for this window
 - Leader + mq reflows the current paragraph to 80 columns
 - Leader + ud toggles dimming (fades every paragraph except the one you're in)
 - j / k move by screen line rather than file line, since lines now wrap
 - zg adds a word to the dictionary; it saves to `nvim/spell/en.utf-8.add` in this repo
 - z= suggests corrections for the word under the cursor

_Nothing is hard-wrapped as you type. `textwidth` is 80 but `formatoptions` has no `t`, so lines are only broken when you ask with `gq`/`gw`._

_Note on line height: Neovim cannot set line spacing in a terminal — that's a terminal setting. `line-height` in `rio/config.toml` is the only lever, and it applies to every Rio window, not just prose._

 The implementation is in `lua/config/prose.lua`, triggered by `after/ftplugin/markdown.lua` and `after/ftplugin/text.lua`.

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

 - I really need to figure out how to do file create, delete, rename, move in Neotree
 - I don't have a great grasp of navigation, I should expand the keybind set and try and unify tmux and nvim navigation nicely
 - By default deletes go to clipboard - if there's no good reason to learn I'd like to change that
 - There's some hacky stuff that hides lualine, popping up the command box when I input a command. This kind of seems like it works, but I might check how other people get status lines at the bottom of their screens. 
 - I should install and try nvimbegood
 - I should look for a better way to name tmux tabs (nvim report directories?)
 - I should get into the habit of opening nvim in different tabs based rather than multiple tabs in nvim
 - I need to figure out how to loop nvim into LSPs

