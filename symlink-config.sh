#!/bin/sh

# resolve paths relative to this script's location, not the caller's cwd (for image builds)
cd "$(dirname "$0")"

ln -s $(realpath ".zshenv") ~/
ln -s $(realpath ".gitconfig") ~/
ln -s $(realpath "zsh") ~/.config/
ln -s $(realpath "tmux") ~/.config/
ln -s $(realpath "nvim") ~/.config/
ln -s $(realpath "rio") ~/.config/
ln -s $(realpath "alacritty") ~/.config/
