return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      -- Format on save through the clang-format CLI, NOT the LSP edit path
      -- that corrupted files. lsp_format = "never" is the key safety setting:
      -- conform replaces the buffer atomically and won't blank it on error.
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
      },
    })
  end,
}
