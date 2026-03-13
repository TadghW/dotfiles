-- Leader should be space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Telescope invokes
vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").live_grep()  end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers()    end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags()  end, { desc = "Help" })

-- Remap window swithing from leader o to leader tab
vim.keymap.set("n", "<leader><Tab>", "<C-w>p", { desc = "Switch window" })
