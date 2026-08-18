-- Prose mode: everything that makes markdown / plain text feel like writing
-- rather than coding. Loaded once from init.lua; the per-buffer bits are
-- triggered from after/ftplugin/{markdown,text}.lua.
--
-- Three layers, kept separate on purpose:
--   1. buffer options  -- travel with the file (textwidth, spelllang, ...)
--   2. window options  -- do NOT travel; re-applied to every window that
--                         shows a prose buffer, including the Zen float
--   3. highlights      -- filetype-scoped groups globally, plus a
--                         window-local namespace for `Normal`
--
-- Note: line height is a terminal setting, not a Neovim one. In a TUI there
-- is no per-buffer line spacing; `linespace` only works in GUI clients such
-- as Neovide. Rio's global `line-height` in rio/config.toml is the only lever.

local M = {}

M.filetypes = { markdown = true, text = true, rmd = true, markdown_inline = true }

---------------------------------------------------------------------------
-- colour helpers
---------------------------------------------------------------------------

-- Fallback so nothing explodes if catppuccin has not loaded yet.
local mocha = {
  rosewater = "#f5e0dc", flamingo = "#f2cdcd", pink = "#f5c2e7", mauve = "#cba6f7",
  red = "#f38ba8", maroon = "#eba0ac", peach = "#fab387", yellow = "#f9e2af",
  green = "#a6e3a1", teal = "#94e2d5", sky = "#89dceb", sapphire = "#74c7ec",
  blue = "#89b4fa", lavender = "#b4befe", text = "#cdd6f4", subtext1 = "#bac2de",
  subtext0 = "#a6adc8", overlay2 = "#9399b2", overlay1 = "#7f849c", overlay0 = "#6c7086",
  surface2 = "#585b70", surface1 = "#45475a", surface0 = "#313244",
  base = "#1e1e2e", mantle = "#181825", crust = "#11111b",
}

local function palette()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then
    return mocha
  end
  local p = palettes.get_palette()
  return (p and p.base) and p or mocha
end

local function to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

-- Mix `fg` over `bg` at `alpha` (0 = all bg, 1 = all fg). Used to build the
-- faint heading / code backgrounds without hardcoding a second palette.
local function blend(fg, bg, alpha)
  local fr, fgn, fb = to_rgb(fg)
  local br, bgn, bb = to_rgb(bg)
  local function mix(f, b)
    return math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(fr, br), mix(fgn, bgn), mix(fb, bb))
end

---------------------------------------------------------------------------
-- highlights
---------------------------------------------------------------------------

-- Window-local highlight namespace. Groups set here only apply to windows we
-- explicitly attach it to, so we can soften `Normal` for prose without
-- touching code buffers. Anything not defined here falls back to the global
-- namespace, so we only need the handful of groups we actually change.
M.ns = vim.api.nvim_create_namespace("prose")

function M.highlights()
  local p = palette()
  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Heading accents. Level 1 is the loudest, then they step down and cool off.
  local heads = {
    { fg = p.mauve, bold = true },
    { fg = p.blue, bold = true },
    { fg = p.sapphire },
    { fg = p.teal },
    { fg = p.green },
    { fg = p.subtext0 },
  }
  for i, head in ipairs(heads) do
    hl("RenderMarkdownH" .. i, { fg = head.fg, bold = head.bold })
    -- A tint of the accent, not a slab of it: 10% at H1 fading to nothing.
    local alpha = math.max(0, 0.11 - (i - 1) * 0.02)
    hl("RenderMarkdownH" .. i .. "Bg", { bg = blend(head.fg, p.base, alpha), fg = head.fg, bold = head.bold })
    hl("@markup.heading." .. i .. ".markdown", { fg = head.fg, bold = head.bold })
  end

  -- Body emphasis. Restrained: bold and italic stay close to body colour so
  -- a paragraph does not turn into a fruit salad.
  hl("@markup.strong", { fg = p.rosewater, bold = true })
  hl("@markup.italic", { fg = p.flamingo, italic = true })
  hl("@markup.strikethrough", { fg = p.overlay1, strikethrough = true })
  hl("@markup.quote.markdown", { fg = p.subtext0, italic = true })

  -- Code recedes in prose rather than standing out.
  hl("RenderMarkdownCode", { bg = p.mantle })
  hl("RenderMarkdownCodeBorder", { bg = blend(p.surface0, p.base, 0.5) })
  hl("RenderMarkdownCodeFallback", { bg = p.mantle, fg = p.subtext0 })
  hl("RenderMarkdownCodeInfo", { bg = p.mantle, fg = p.overlay1, italic = true })
  hl("RenderMarkdownCodeInline", { bg = blend(p.surface0, p.base, 0.75), fg = p.peach })
  hl("@markup.raw.markdown_inline", { bg = blend(p.surface0, p.base, 0.75), fg = p.peach })

  -- Structure: present but quiet.
  hl("RenderMarkdownBullet", { fg = p.overlay2 })
  hl("RenderMarkdownDash", { fg = p.surface2 })
  hl("RenderMarkdownIndent", { fg = p.surface1 })
  hl("RenderMarkdownSign", { fg = p.surface1 })
  hl("RenderMarkdownTableHead", { fg = p.subtext0, bold = true })
  hl("RenderMarkdownTableRow", { fg = p.overlay2 })

  -- Quotes cycle by nesting depth, cool to warm.
  local quotes = { p.lavender, p.sapphire, p.teal, p.green, p.yellow, p.peach }
  for i, colour in ipairs(quotes) do
    hl("RenderMarkdownQuote" .. i, { fg = blend(colour, p.base, 0.7) })
  end

  -- Links and tasks.
  hl("RenderMarkdownLink", { fg = p.sky })
  hl("RenderMarkdownLinkTitle", { fg = p.lavender, underline = true })
  hl("RenderMarkdownWikiLink", { fg = p.lavender })
  hl("@markup.link.label.markdown_inline", { fg = p.lavender })
  hl("@markup.link.url.markdown_inline", { fg = p.overlay1, underline = true })
  hl("RenderMarkdownUnchecked", { fg = p.overlay1 })
  hl("RenderMarkdownChecked", { fg = p.green })
  hl("RenderMarkdownTodo", { fg = p.yellow })
  hl("RenderMarkdownInlineHighlight", { bg = blend(p.yellow, p.base, 0.2), fg = p.text })

  -- Callouts (> [!NOTE] and friends).
  hl("RenderMarkdownSuccess", { fg = p.green })
  hl("RenderMarkdownInfo", { fg = p.sky })
  hl("RenderMarkdownHint", { fg = p.teal })
  hl("RenderMarkdownWarn", { fg = p.yellow })
  hl("RenderMarkdownError", { fg = p.red })
  hl("RenderMarkdownMath", { fg = p.peach, italic = true })

  -- Spelling: an undercurl, no background, so it does not fight the text.
  hl("SpellBad", { sp = p.red, undercurl = true })
  hl("SpellCap", { sp = p.yellow, undercurl = true })
  hl("SpellRare", { sp = p.mauve, undercurl = true })
  hl("SpellLocal", { sp = p.teal, undercurl = true })

  -- Window-local namespace: body text one notch softer than code, and a
  -- cursorline faint enough to track without distracting.
  local set_ns = function(group, opts)
    vim.api.nvim_set_hl(M.ns, group, opts)
  end
  set_ns("Normal", { fg = p.subtext1, bg = p.base })
  set_ns("NormalFloat", { fg = p.subtext1, bg = p.base })
  set_ns("CursorLine", { bg = blend(p.surface0, p.base, 0.45) })
  set_ns("NonText", { fg = p.surface1 })
  set_ns("Whitespace", { fg = p.surface1 })
  set_ns("EndOfBuffer", { fg = p.base })
end

---------------------------------------------------------------------------
-- options
---------------------------------------------------------------------------

-- Buffer-local. These follow the file into any window.
function M.buf_options(buf)
  local bo = vim.bo[buf]
  bo.textwidth = 80
  -- No `t`/`c`: nothing hard-wraps while you type. `gq` / `gw` still reflow
  -- to 80 on demand. `n` keeps list indentation when reflowing, `1` avoids
  -- ending a line on a one-letter word, `j` tidies joins.
  bo.formatoptions = "jnql1"
  bo.formatlistpat = [[^\s*\%(\d\+[.)]\|[-*+]\|>\+\)\s\+]]
  bo.spelllang = "en_gb"
  bo.spelloptions = "camel"
  -- Words added with `zg` land here, inside the dotfiles repo, so a good
  -- dictionary follows the config around instead of living in ~/.local.
  bo.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
  bo.expandtab = true
  bo.shiftwidth = 2
  bo.tabstop = 2
  bo.softtabstop = 2
  bo.smartindent = false
  bo.autoindent = true
end

-- Window-local. These do not travel with the buffer, so they are re-applied
-- by autocmd to every window that ends up showing a prose buffer -- splits,
-- new tabs, and the Zen float.
--
-- `conceallevel` is deliberately absent: render-markdown owns it via its own
-- win_options and flips it between 0 and 3 as it renders. Setting it here
-- would fight the plugin on every WinEnter.
--
-- Written through nvim_set_option_value with an explicit `scope = "local"`.
-- `vim.wo[win].foo = x` looks window-local but behaves like `:set` -- it
-- writes the global value too, so every code buffer opened afterwards would
-- inherit `nonumber`, `spell` and `signcolumn=no`.
M.WIN_VALUES = {
  wrap = true,
  linebreak = true, -- wrap at word boundaries, not mid-word
  breakindent = true,
  breakindentopt = "",
  showbreak = "  ", -- continuation marker render-markdown expects for quotes
  number = false,
  relativenumber = false,
  signcolumn = "no",
  foldcolumn = "0",
  colorcolumn = "",
  list = false,
  cursorline = true,
  cursorcolumn = false,
  spell = true,
  scrolloff = 6,
}

function M.win_options(win)
  for opt, value in pairs(M.WIN_VALUES) do
    pcall(vim.api.nvim_set_option_value, opt, value, { win = win, scope = "local" })
  end
end

local function is_prose(buf)
  return M.filetypes[vim.bo[buf].filetype] or false
end

-- Window options survive a buffer swap: `:e foo.lua` in a prose window would
-- otherwise keep spell, the hidden number column and the rest.
--
-- Restoring is done from the *global* value of each option -- what a freshly
-- opened window would get -- rather than from a per-window snapshot. A
-- snapshot is unreliable here because new windows inherit their options from
-- the window they were created out of: `:split` from a prose window, or the
-- Zen float, would both "snapshot" values that are already prose-shaped and
-- then restore prose settings onto a code buffer.
local in_prose = {} ---@type table<integer, true>

local function restore_win(win)
  if not in_prose[win] then
    return
  end
  in_prose[win] = nil
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  for opt in pairs(M.WIN_VALUES) do
    local ok, value = pcall(vim.api.nvim_get_option_value, opt, { scope = "global" })
    if ok then
      pcall(vim.api.nvim_set_option_value, opt, value, { win = win, scope = "local" })
    end
  end
end

-- Attach or detach the prose highlight namespace for a window.
local function sync_ns(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  local buf = vim.api.nvim_win_get_buf(win)
  pcall(vim.api.nvim_win_set_hl_ns, win, is_prose(buf) and M.ns or 0)
end

-- Apply window options + namespace to every window currently showing prose.
--
-- Options are written once per (window, buffer) pair, recorded in `w:prose`.
-- Without that guard every WinEnter would stomp on manual toggles -- turning
-- `spell` back on ten seconds after you turned it off.
local function sync_windows(force)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
    if ok then
      if is_prose(buf) then
        if force or vim.w[win].prose ~= buf then
          pcall(M.win_options, win)
          in_prose[win] = true
          vim.w[win].prose = buf
        end
      else
        if vim.w[win].prose ~= nil then
          vim.w[win].prose = nil
        end
        restore_win(win)
      end
      sync_ns(win)
    end
  end
end

M.sync = sync_windows

---------------------------------------------------------------------------
-- keymaps (buffer-local)
---------------------------------------------------------------------------

function M.keymaps(buf)
  local map = function(mode, lhs, rhs, desc, extra)
    local opts = { buffer = buf, desc = desc, silent = true }
    for k, v in pairs(extra or {}) do
      opts[k] = v
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- With wrap on, j/k should move by what you see, not by file line. These are
  -- expression maps: the `v:count == 0` guard keeps 5j jumping five real lines
  -- so relative-number style motions still work.
  map({ "n", "x" }, "j", function()
    return vim.v.count == 0 and "gj" or "j"
  end, "Down (visual line)", { expr = true })
  map({ "n", "x" }, "k", function()
    return vim.v.count == 0 and "gk" or "k"
  end, "Up (visual line)", { expr = true })
  map({ "n", "x" }, "0", "g0", "Start of visual line")
  map({ "n", "x" }, "$", "g$", "End of visual line")
  map("i", "<Down>", "<C-o>gj", "Down (visual line)")
  map("i", "<Up>", "<C-o>gk", "Up (visual line)")

  -- Reflow the current paragraph to 80 columns.
  map("n", "<leader>mq", "gqip", "Prose: reflow paragraph")
  map("x", "<leader>mq", "gq", "Prose: reflow selection")

  map("n", "<leader>ms", function()
    -- scope = "local" so this only affects this window, not the global default
    local win = vim.api.nvim_get_current_win()
    local on = not vim.api.nvim_get_option_value("spell", { win = win, scope = "local" })
    vim.api.nvim_set_option_value("spell", on, { win = win, scope = "local" })
    vim.notify("spell " .. (on and "on" or "off"))
  end, "Prose: toggle spell")

  map("n", "<leader>mr", "<cmd>RenderMarkdown buf_toggle<cr>", "Prose: toggle markdown rendering")
end

-- Entry point called by after/ftplugin/*.lua.
function M.on_buffer(buf)
  if buf == nil or buf == 0 then
    buf = vim.api.nvim_get_current_buf()
  end
  if vim.bo[buf].buftype ~= "" then
    return -- help, quickfix, terminal, etc. are not prose
  end
  M.buf_options(buf)
  M.keymaps(buf)
  sync_windows(false)
end

---------------------------------------------------------------------------
-- zen
---------------------------------------------------------------------------

-- Set to false to stop prose files auto-entering Zen (also `<leader>mz`).
if vim.g.prose_auto_zen == nil then
  vim.g.prose_auto_zen = true
end

local function zen_open()
  local snacks = _G.Snacks
  if not snacks or not snacks.zen then
    return false
  end
  -- Snacks.zen() toggles, so bail out if a Zen window is already up,
  -- otherwise opening a second markdown file would close the first.
  if snacks.zen.win and snacks.zen.win:valid() then
    return true
  end
  snacks.zen()
  return true
end

local function maybe_auto_zen(buf)
  if not vim.g.prose_auto_zen then
    return
  end
  -- The FileType event was deferred; make sure this buffer is still the one
  -- in front of us before hijacking the screen with a float.
  if vim.api.nvim_get_current_buf() ~= buf then
    return
  end
  if vim.bo[buf].buftype ~= "" or vim.wo.diff then
    return
  end
  -- Only for real files on disk; scratch buffers and previews are skipped.
  if vim.api.nvim_buf_get_name(buf) == "" then
    return
  end
  -- Already inside a float (telescope preview, another zen): leave it alone.
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    return
  end
  zen_open()
end

---------------------------------------------------------------------------
-- setup
---------------------------------------------------------------------------

function M.setup()
  local group = vim.api.nvim_create_augroup("prose", { clear = true })

  M.highlights()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      M.highlights()
      sync_windows(true)
    end,
  })

  -- Window options do not survive being shown in a new window, so re-apply
  -- them whenever the window/buffer pairing changes.
  vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "WinNew" }, {
    group = group,
    callback = function()
      vim.schedule(function()
        sync_windows(false)
      end)
    end,
  })

  -- Stop tracking windows that no longer exist.
  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(args)
      in_prose[tonumber(args.match)] = nil
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "markdown", "text", "rmd" },
    callback = function(args)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          maybe_auto_zen(args.buf)
        end
      end)
    end,
  })

  vim.keymap.set("n", "<leader>mz", function()
    vim.g.prose_auto_zen = not vim.g.prose_auto_zen
    vim.notify("prose auto-zen " .. (vim.g.prose_auto_zen and "on" or "off"))
  end, { desc = "Prose: toggle auto-zen" })
end

return M
