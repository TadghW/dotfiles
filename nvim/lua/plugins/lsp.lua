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
      local mason_lspconfig = require("mason-lspconfig")

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      vim.filetype.add({
        pattern = {
          [".*%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
        },
      })

      local opts = {
        ensure_installed = {
          "pyrefly",
          "ruff",
          "shuck",
          "docker_language_server",
          "superhtml",
          "csskit",
          "denols",
          "gitlab_ci_ls",
          "dprint",
          "gopls",
          "lua_ls",
          "marksman",
          "rust_analyzer",
        },
        automatic_enable = true,
      }

      mason_lspconfig.setup(opts)

      vim.lsp.config("pyrefly", {
        settings = {
          python = {
            pyrefly = {
              typeCheckingMode = "default",
            },
          },
        },
      })
    end,
  },
}
