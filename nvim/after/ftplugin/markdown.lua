-- Prose mode for markdown. Rendering itself is handled by
-- render-markdown.nvim; this is wrap / spell / colours / keymaps.
require("config.prose").on_buffer(0)

-- render-markdown needs an active treesitter parser. Neovim 0.11 ships the
-- markdown and markdown_inline parsers, so no nvim-treesitter install is
-- needed -- but nothing starts the highlighter for us.
pcall(vim.treesitter.start, 0, "markdown")
