return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin-mocha",
      },
    })
  end,
}
