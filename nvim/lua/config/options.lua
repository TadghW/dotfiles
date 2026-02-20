vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = false
 -- vim.opt.cursorline = true
 -- vim.opt.cursorcolumn = true

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
