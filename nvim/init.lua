vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.termguicolors = true

vim.opt.confirm = true

require("config.lazy")
require("config.colors")
require("config.keymaps")
require("plugins.telescope")
require("plugins.neotree")
require("plugins.alpha-nvim")

vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep()  end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers()    end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags()  end, { desc = "Help" })


