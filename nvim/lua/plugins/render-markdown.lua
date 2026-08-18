-- render-markdown.nvim -- draws markdown in the buffer instead of only
-- syntax-highlighting it: headings get icons and tinted backgrounds, code
-- blocks get a block background, `- [ ]` becomes a real checkbox, tables get
-- box-drawing borders. It renders in normal mode and un-renders the line you
-- are editing, so the underlying text is never modified.
--
-- Colours come from config/prose.lua, not from here.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    file_types = { "markdown" },
    -- Render in normal and command mode; insert and visual show raw text so
    -- you can see exactly what you are editing.
    render_modes = { "n", "c" },

    -- Reveal the raw text of whatever the cursor is on, plus one line either
    -- side, so editing a heading or link is not a guessing game.
    anti_conceal = { enabled = true, above = 1, below = 1 },

    heading = {
      -- Unicode circled numerals, so the level is readable at a glance.
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      position = "inline",
      width = "block",
      min_width = 60,
      left_pad = 0,
      right_pad = 2,
      sign = false,
      border = false,
    },

    paragraph = { enabled = true },

    code = {
      width = "block",
      min_width = 60,
      right_pad = 2,
      left_pad = 1,
      border = "thin",
      language_name = true,
      language_icon = true,
      sign = false,
      -- These highlight their own background already.
      disable_background = { "diff" },
    },

    bullet = {
      icons = { "•", "◦", "▪", "▫" },
      right_pad = 1,
    },

    checkbox = {
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        cancelled = { raw = "[~]", rendered = "󰰱 ", highlight = "RenderMarkdownDash" },
      },
    },

    quote = {
      icon = "▎",
      -- Needs showbreak='  ', breakindent and breakindentopt='' -- all set in
      -- config/prose.lua win_options.
      repeat_linebreak = true,
    },

    dash = { icon = "─", width = "full" },

    pipe_table = { preset = "round", style = "full" },

    -- The sign column is off in prose mode, so nothing to draw there.
    sign = { enabled = false },

    -- Requires an external `utftex`/`latex2text` binary; off to avoid a
    -- health warning for something not in use.
    latex = { enabled = false },

    -- These two need the `html` and `yaml` treesitter parsers, which Neovim
    -- does not bundle. Turning them off keeps `:checkhealth render-markdown`
    -- clean and avoids pulling in nvim-treesitter just for them. The cost is
    -- that YAML frontmatter and inline HTML render as plain text.
    html = { enabled = false },
    yaml = { enabled = false },
  },
}
