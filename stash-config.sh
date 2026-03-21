#!/bin/bash

# If old config folder exists
# Move config folder to same location and add timestamp or succession of "old" (probably timestamp)

err() {
 local error=$1
 printf "%s\n" "$error"
 return 1
}

backup_if_exists(){
  local path=$1
  [[ -n "$path" ]] || err "Path is empty!" || return 1
  [[ -e "$path" ]] || return 0
  local timestamp=$(date +%s) || err "Failed to get timestamp" || return 1
  local backup_path="${path}.${timestamp}"
  local mv_error
  if ! mv_error=$(mv "$path" "$backup_path" 2>&1); then
      err "Failed to move $path to $backup_path: $mv_error"
      return 1
    fi
  return 0
}

backup_if_exists ~/.bashrc
backup_if_exists ~/.bash_profile
backup_if_exists ~/.gitconfig
backup_if_exists ~/.config/alacritty
backup_if_exists ~/.config/rio
backup_if_exists ~/.config/tmux
backup_if_exists ~/.config/nvim
