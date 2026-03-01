return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local mason_lspconfig = require("mason-lspconfig")
      local handlers = {
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      }

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      local opts = {
        -- Bulk preinstall: a broad, sane default set.
        ensure_installed = {
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "rust_analyzer",
          "taplo",
          "ts_ls",
          "yamlls",
        },
        -- Auto-install when a matching filetype is opened.
        automatic_installation = true,
      }

      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup(opts)
        mason_lspconfig.setup_handlers(handlers)
      else
        opts.handlers = handlers
        mason_lspconfig.setup(opts)
      end
    end,
  },
}
