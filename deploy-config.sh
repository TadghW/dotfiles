#!/bin/bash

err() {
 local error=$1
 printf "%s\n" "$error"
 return 1
}

create_config_folder_if_missing(){
  if ! [[ -d "$HOME/.config" ]]; then
    echo "$HOME/.config doesn't exist - creating..."
    mkdir -p "$HOME/.config" || err "Couldn't create ~/.config"
  fi
  return 0
}

create_config_folder_if_missing

echo "Backing up existing configuration..."

stash_if_exists(){
  local path=$1
  if [[ -e "$path" ]]; then
    mkdir -p "$HOME/.config/old-config"
    local timestamp=$(date +%s) 
    local backup_path="$HOME/.config/old-config/$(basename "$path").$timestamp"
    local mv_error
    if ! mv_error=$(mv "$path" "$backup_path" 2>&1); then
        err "Failed to move $path to $backup_path: $mv_error"
        return 1
    fi
  fi
  return 0
}

stash_if_exists ~/.zshenv
stash_if_exists ~/.gitconfig
stash_if_exists ~/.config/zsh
stash_if_exists ~/.config/rio
stash_if_exists ~/.config/tmux
stash_if_exists ~/.config/nvim
stash_if_exists ~/.config/alacritty

echo "Linking new config..."

# resolve paths relative to this script's location, not the caller's cwd (for image builds)
cd "$(dirname "$0")"

: ' add_configuration()
    arg1: program name as it should be printed
    arg2: command used to check install status
    arg3+: source of config (this repo) and install destination delimited by :
'

add_configuration(){
  local program=$1
  local checkCommand=$2
  shift 2
  local pair source destination
  if ! $checkCommand 1>/dev/null 2>&1; then
    echo "$program not found - skipping $program config"
  else
    for pair in "$@"; do
      source=${pair%%:*}
      destination=${pair#*:}
      ln -s "$(realpath "$source")" "$destination"
    done
    echo "$program configured"
  fi
  return 0
}

add_configuration "git" "git -v" ".gitconfig:$HOME"
add_configuration "zsh" "zsh --version" ".zshenv:$HOME" "zsh:$HOME/.config/"
add_configuration "tmux" "tmux -V" "tmux:$HOME/.config/" 

if [[ ! -d ~/.config/tmux/plugins/catppuccin/tmux ]]; then
  echo "Cloning catppuccin theme for tmux..."
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

add_configuration "neovim" "nvim -v" "nvim:$HOME/.config/" 
add_configuration "rio" "rio --version" "rio:$HOME/.config/" 
add_configuration "alacritty" "alacritty --version" "alacritty:$HOME/.config/" 

echo "Done!"
echo "Pre-existing config has been timestamped and left in ~/.config/old-config."
