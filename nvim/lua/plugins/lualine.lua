return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
  config = function()
    local function commandline_component()
      if vim.api.nvim_get_mode().mode ~= "c" then
        return ""
      end

      local cmd_type = vim.fn.getcmdtype()
      local cmd_line = vim.fn.getcmdline()
      if cmd_type == "" and cmd_line == "" then
        return ""
      end

      return cmd_type .. cmd_line
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin-mocha",
        globalstatus = true,
      },
      sections = {
        lualine_c = { "filename", commandline_component },
      },
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
        refresh_time = 16,
        events = {
          "WinEnter",
          "BufEnter",
          "BufWritePost",
          "SessionLoadPost",
          "FileChangedShellPost",
          "VimResized",
          "Filetype",
          "CursorMoved",
          "CursorMovedI",
          "ModeChanged",
          "CmdlineEnter",
          "CmdlineChanged",
          "CmdlineLeave",
        },
      },
    })
  end,
}
