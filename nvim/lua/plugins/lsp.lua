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
      -- mason-lspconfig 2.x removed `setup_handlers()`, the `handlers` option
      -- and `automatic_installation`. Unknown keys are merged in silently by
      -- vim.tbl_deep_extend, so the old config failed without warning. Servers
      -- are now attached by `automatic_enable`; per-server settings go through
      -- vim.lsp.config("<server>", { ... }), not a handler function.
      local mason_lspconfig = require("mason-lspconfig")

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
      })

      -- gitlab_ci_ls only attaches to the compound filetype "yaml.gitlab",
      -- which Neovim does not detect on its own -- .gitlab-ci.yml comes
      -- through as plain "yaml", so the server would never start. The pattern
      -- also catches split pipelines like .gitlab-ci-barius.yml. The "yaml."
      -- prefix is kept so normal YAML syntax and settings still apply.
      vim.filetype.add({
        pattern = {
          [".*%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
        },
      })

      local opts = {
        -- Node-free server set. Every entry here is a self-contained native
        -- binary (Rust/Go/Zig), so nothing needs `node` on PATH. The previous
        -- npm-based servers all died with exit 127 ("env: node: No such file
        -- or directory") because node is not installed on this machine.
        --
        -- Names must be *lspconfig* server names -- mason-lspconfig resolves
        -- them to mason packages via each package's `neovim.lspconfig` field.
        ensure_installed = {
          -- Python: pyright split into a type checker + a linter/formatter.
          "pyrefly", -- type errors, hover, go-to-def (was: pyright)
          "ruff", -- lint, format, import sorting
          -- Shell / containers / web
          "shuck", -- was: bashls
          "docker_language_server", -- was: dockerls
          "superhtml", -- was: html
          "csskit", -- was: cssls
          -- TS/JS. Deno-oriented: it resolves Deno-style imports rather than
          -- node_modules, so it can be noisy in an npm project. Drop this line
          -- if that bites. (was: ts_ls)
          "denols",
          -- CI YAML. There is no node-free *general* YAML server, so this
          -- covers .gitlab-ci.yml specifically instead of all YAML.
          "gitlab_ci_ls", -- partial replacement for: yamlls
          -- Formatting for json/jsonc/toml/markdown/python/ts/rust/graphql.
          -- Formatter only: no schema validation, completion or hover, so it
          -- is not a like-for-like stand-in for the taplo TOML server it
          -- replaces -- TOML now has formatting but no diagnostics.
          --
          -- It attaches even with no dprint.json present (root_markers just
          -- fail to match and the client still starts), but it is then a
          -- silent no-op: formatting appears to succeed and changes nothing,
          -- because dprint loads no plugins without a config. Run `dprint
          -- init` per repo, or `dprint init --global`, to make it do work.
          -- Harmless alongside ruff on Python: dprint returns no edits, so an
          -- unfiltered vim.lsp.buf.format() still gets ruff's formatting.
          "dprint", -- replaces: taplo
          -- Already native, unchanged.
          "gopls",
          "lua_ls",
          "marksman",
          "rust_analyzer",
        },
        -- Auto-enable installed servers via vim.lsp.enable(). This is the
        -- only mechanism that attaches servers now (see the note at the top
        -- of this function). It enables everything *installed*, so keeping
        -- mason free of unused servers is what keeps this honest -- the old
        -- npm packages have been uninstalled rather than excluded here.
        automatic_enable = true,
      }

      mason_lspconfig.setup(opts)

      -- Without this, pyrefly is silent in most repos. Its default preset for
      -- files not covered by a pyrefly.toml is "auto", which falls back to
      -- "basic" when it finds no mypy/pyright config -- and "basic" ignores
      -- return-type mismatches, bad arguments, bad attributes and bad
      -- assignments. Measured on a file with 5 deliberate type errors:
      --   basic -> 1 found        default -> 5 found
      --   strict -> 5 found      all     -> 5 found
      -- "default" is the useful floor without strict's extra pedantry.
      --
      -- Trade-off: "auto" would instead migrate a repo's existing
      -- [tool.pyright] config (batmake has one), giving diagnostics that match
      -- what `task pyright` reports in CI. Switch this one word to "auto" if
      -- matching CI matters more than catching errors in unconfigured repos.
      -- A repo-local pyrefly.toml still overrides this either way.
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
