-- nvim-treesitter -- parses a buffer into a syntax tree and highlights from
-- that tree instead of from regex patterns. Written in Lua; the parsers it
-- builds are C, compiled locally with `cc`. Nothing here needs node.
--
-- Neovim already bundles seven parsers in lib/nvim/parser (c, lua, vim,
-- vimdoc, query, markdown, markdown_inline) -- which is why render-markdown
-- has always worked. Everything else, python included, had no parser, so
-- those filetypes fell back to Vim's old regex syntax engine.
return {
  "nvim-treesitter/nvim-treesitter",

  -- Pinned to master on purpose. The repo's default branch is now `main`, a
  -- rewrite that requires **Neovim 0.12 nightly** and the tree-sitter CLI.
  -- This machine runs 0.11.2, which only master supports (0.10-0.11).
  branch = "master",

  -- Recompiles parsers after the plugin updates. master requires parsers and
  -- plugin queries to move together; a stale parser throws query errors.
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      -- Parsers are fetched as pre-generated C and compiled with cc, so no
      -- tree-sitter CLI is involved for anything in this list.
      ensure_installed = {
        -- Day job: build systems, CI, containers, IaC.
        "bash",
        "cmake",
        "dockerfile",
        "hcl", -- also covers .tf when terraform is absent
        "make",
        "python",
        "yaml",
        -- Config / data formats.
        "ini",
        "json",
        "jsonc",
        "toml",
        "xml",
        -- Game repos are CMake + C++.
        "c",
        "cpp",
        -- Other languages with a server already installed.
        "go",
        "lua",
        "rust",
        "css",
        "html",
        "javascript",
        "typescript",
        -- Editor + git plumbing. `query` is for treesitter's own .scm files.
        "diff",
        "gitattributes",
        "gitcommit",
        "git_rebase",
        "gitignore",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "vimdoc",
      },

      -- Compile in the background so startup is not blocked on first run.
      sync_install = false,

      -- Deliberately off. auto_install fetches a grammar on demand, which
      -- needs the tree-sitter CLI at version <= 0.25.x; mason only offers
      -- 0.27.0, which master rejects. Add parsers to the list above instead.
      auto_install = false,

      highlight = {
        enable = true,
        -- Running both highlighters doubles the work and produces duplicate
        -- highlights. config/prose.lua already styles the @markup.* groups
        -- treesitter emits, so the regex engine is not needed underneath.
        additional_vim_regex_highlighting = false,
      },

      -- Left off: master's indent module is upstream-flagged experimental and
      -- would change how every buffer indents. Enable deliberately, not as a
      -- side effect of wanting highlighting.
      indent = { enable = false },
    })
  end,
}
