vim.g.loaded_netrw = 1
vim.g.loaded_netwrPlugin = 1

require("config.keymaps")
require("config.options")
require("config.colors")
require("config.lazy")

-- After lazy, so the colourscheme is already applied and our prose highlight
-- overrides land on top of catppuccin's rather than under them.
require("config.prose").setup()
