return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Neo-tree toggle" },
    { "<leader>b", "<cmd>Neotree toggle buffers<cr>", desc = "Neo-tree buffers" },
  },
  
  config = function()

    vim.opt.hidden = false
    vim.opt.switchbuf = { "useopen" }

    require("neo-tree").setup({

      close_if_last_window = true,
      enable_git_status = true,
 
      sources = { 
        "filesystem",
        "buffers",
        "git_status"
      },
      
      source_selector = { 
        winbar = true,
        statusline = false 
      },

      window = { 
        position = "left", 
        width = 32 
      },

      buffers = {
        follow_current_file = {
          enabled = true
        },
        group_empty_dirs = true,
        show_unloaded = false,
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true
        },
        use_libuv_file_watcher = true,
      }
    })
     
    vim.keymap.set("n", "<leader>o", "<cmd>wincmd p<cr>", { desc = "Jump to other window" })
  end,
}
