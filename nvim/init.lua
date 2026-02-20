vim.g.loaded_netrw = 1
vim.g.loaded_netwrPlugin = 1

require("config.keymaps")
require("config.options")
require("config.colors")
require("config.lazy")

vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep()  end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers()    end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags()  end, { desc = "Help" })


