# Tadgh's Dotfiles

## This project

Contains all of the configuration files I use to configure my compters' terminal emulators and TUI apps, including:

 - My `.bashrc` for shell configuration
 - My `.bash_profile` for sourcing the shell configuration when logging in over SSH
 - My `.gitconfig` for configuring git
 - Configuration folders for `alacritty` and `rio`
 - Configuration for the `tmux` terminal multiplexer
 - Configuration for the `neovim` text editor
 - Helper scripts for installing the configuration

 When I'm working in a new unix-like environment I install `git`, `tmux`, `neovim`, and `rio` - then clone this repo and run `deploy-config.sh` - which deploys my configuration

## To Use

Clone the repo and run `deploy-config.sh`! `deploy-config.sh` runs `stash-config.sh` which copies out any existing config you have to new files / folders, then runs `symlink-config.sh` which creates symlinks in your home and .config folders to your local copy of this repo. The boring, copy-only version of this is provided by `copy-config.sh`. Both scripts will run a clone the catppuccin tmux theme with:

`git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux`

If you don't want to keep your old config around, run `remove-stashed-configs.sh` for cleanup

If you want to update anything work in your copy of the repo, the changes will be reloaded automatically when the apps are! (Except for Rio, which will auto-reload most config because it's cool like that) (Tmux will reload most config if you hit Ctrl A + R) 

You will want to customise `.gitconfig` - it has my name, email, and merge preferences in it. 

## How it's configured:

- I recommend using [Rio](https://rioterm.com/) as your terminal emulator - it's very cross-platform and easy to configure. You can see my Rio config in `dotfiles/rio/`.
- Remember to find and apply a theme to your terminal emulator for maximum eye-comfort :)
- You'll be launched automatically into a `tmux` session when you log in. This behaviour is configured in `dotfiles/.bashrc-auto-tmux`, which is renamed to `.bashrc` on installation, and sourced by `.bash_profile` when you log in to the container. To use my `tmux` config:
  1. Prefix is `Ctrl + A`
  2. `Prefix + -` for vertical split `Prefix + |` for horizontal.
  3. `Prefix + Arrow keys` to resize a pane
  4. `Prefix + ` `h`, `j`, `k`, and `l` for navigation.
  5. `Prefix + x` to close a pane
  6. `Prefix + c` to create a new window
  7. Close all panes to close a window
  8. `Prefix + n` to move to the next window
  9. `Prefix + p` to move to the previous window
  10. `Prefix + {NUMBER}` to move to a specific window
  11. `Prefix + r` reloads the config.
- My text editor is `nvim` with `lazy-nvim`, `Mason`, `telescope`, `neotree`, and `alpha-nvim`:
  1. Leader is `space`
  2. `Leader + e` to open neotree
  3. `Leader + b` to open neotree on open buffers
  4. `Leader + tab` to swap between windows
  5. `Leader + fs` to search context for strings
  6. `Leader + ff` to search context for files.
  7. Otherwise, stock navigation
- For `nvim` and `ohmyposh` (my shell prompt fancy-ifier) to render properly you'll need to configure your terminal emulator to use an font that has been patched with many nerdy icons - I recommend looking through through nerd-fonts to find one you like. I like `JetbrainsMono`.
- I have no alias other than the one I use to connect to the workspace which is `workspace` - avoid using this from within the workspace as it will nest.
