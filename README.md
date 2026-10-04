# Tadgh's Dotfiles

## This project

Contains all of the configuration files I use to configure my computers' terminal emulators and TUI apps, including:

 - My `.zshenv` for correctly sourcing my `zsh` config
 - My `.gitconfig` for configuring git
 - Configuration for the `zsh` shell
 - Configuration folders for `alacritty` and `rio`
 - Configuration for the `tmux` terminal multiplexer
 - Configuration for the `neovim` text editor
 - My global `CLAUDE.md` for Claude Code (linked to `~/.claude/CLAUDE.md`)
 - Scripts for deploying and removing the configuration

When I'm working in a new unix-like environment I install `zsh`, `git`, `tmux`, `neovim`, and `rio` - then clone this repo and run `deploy-config.sh` - which deploys my configuration.

## To Use

Clone the repo and run `deploy-config.sh`! It stashes any existing config into `~/.config/old-config`, timestamped, then symlinks your home and .config folders to your local copy of this repo. Anything you haven't installed gets skipped. It'll also clone the catppuccin tmux theme.

To rip the deployed config back out, run `remove-config.sh`. It leaves `~/.config/old-config` alone - delete that yourself once you're happy.

If you want to update anything, work in your copy of the repo - the changes will be picked up when the apps are restarted! (Except for Rio, which will auto-reload most config because it's cool like that) (Tmux will reload most config if you hit `Prefix + r`)

You will want to customise `.gitconfig` - it has my name, email, and merge preferences in it.

## How it's configured:

- I recommend using [Rio](https://rioterm.com/) as your terminal emulator - it's very cross-platform and easy to configure. You can see my Rio config in `dotfiles/rio/`. There's also an `alacritty` config in `dotfiles/alacritty/` if you prefer that.
- Remember to find and apply a theme to your terminal emulator for maximum eye-comfort :)
- For `nvim` to render properly you'll need to configure your terminal emulator to use a font that has been patched with many nerdy icons - I recommend looking through nerd-fonts to find one you like. I like `JetbrainsMono`.
- My shell aliases are `reload-shell` (re-sources `.zshrc`) and `modify-shell` (opens `.zshrc` in `nvim`).

### tmux

Prefix is `Ctrl + A`.

| Keys | Action |
|---|---|
| `Prefix + -` | Split into top/bottom panes |
| `Prefix + \|` | Split into side-by-side panes |
| `Prefix + h` / `l` | Move to the pane left / right |
| `Prefix + j` / `k` | Move to the pane above / below |
| `Prefix + Arrow keys` | Resize the current pane |
| `Prefix + x` | Close the current pane |
| `Prefix + c` | Create a new window (close all its panes to close it) |
| `Prefix + n` / `p` | Next / previous window |
| `Prefix + {NUMBER}` | Go to a specific window |
| `Prefix + r` | Reload the config |
| `v`, then `y` (copy mode) | Select, then copy to the system clipboard |
| `Prefix + P` | Paste the tmux buffer |

Copying uses `pbcopy` on macOS. On Linux it uses `wl-copy` (Wayland), `xclip`, or `xsel` - whichever is installed.

### nvim

Uses `lazy-nvim`, `Mason`, `telescope`, `neotree`, and `alpha-nvim`. Leader is `space`; otherwise, stock navigation.

| Keys | Action |
|---|---|
| `Leader + e` | Open neotree |
| `Leader + b` | Open neotree on open buffers |
| `Leader + git` | Open neotree on git status |
| `Leader + tab` (or `Leader + o`) | Swap between windows |
| `Leader + ff` | Search for files |
| `Leader + fs` | Search for strings |
| `Leader + fb` | Search open buffers |
| `Leader + fh` | Search help |
| `Leader + z` / `Z` | Zen mode / zoom the current window |
| `Leader + ud` / `us` / `uw` | Toggle dimming / spelling / wrap |
| `Leader + mz` | Toggle auto-zen for prose files |

In markdown and text files only:

| Keys | Action |
|---|---|
| `Leader + mq` | Reflow paragraph (or selection) |
| `Leader + ms` | Toggle spelling |
| `Leader + mr` | Toggle markdown rendering |
