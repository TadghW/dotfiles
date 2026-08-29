-- snacks.nvim is a collection of ~25 small modules. Only the ones given an
-- `enabled = true` (or invoked directly) actually do anything, so this pulls
-- in zen and dim and leaves the rest dormant.
--
--   zen -- reopens the current buffer in a centred floating window, hides the
--          statusline/tabline, and dims everything behind it.
--   dim -- fades out every paragraph except the one the cursor is in.
--
-- Zen is opened automatically for markdown/text by config/prose.lua.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      show = { statusline = false, tabline = false },
      win = {
        -- 80 columns of text plus a little breathing room on each side.
        width = 84,
        height = 0, -- full height
        -- `transparent = false` is what makes the surround genuinely opaque:
        -- snacks then bakes a solid colour and sets winblend=0 on the backdrop
        -- window, instead of laying a see-through dim over the buffer behind.
        -- The file underneath stops showing through entirely.
        --
        -- `blend` here is no longer an opacity: it is how far the backdrop
        -- colour sits between black (0) and the normal background (100), so
        -- 60 gives a surround clearly darker than the text column. 100 is not
        -- usable -- snacks reads it as "no backdrop" and skips the window.
        backdrop = { transparent = false, blend = 60 },
      },
    },
    dim = {
      -- Prose paragraphs are short; without a small min_size dim flickers
      -- between one-line scopes as you move.
      scope = { min_size = 3, max_size = 40, siblings = true },
      animate = { enabled = true, duration = { step = 15, total = 250 } },
    },
  },
  keys = {
    { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom (maximise window)" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Registering the toggle gives it the id "dim", which is what the zen
        -- `toggles` table above looks up. Without this, zen silently skips it.
        Snacks.toggle.dim():map("<leader>ud")
        Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
      end,
    })
  end,
}
