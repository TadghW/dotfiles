-- Leader should be space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Remap window swithing from leader o to leader tab
vim.keymap.set("n", "<leader><Tab>", "<C-w>p", { desc = "Switch window" })
