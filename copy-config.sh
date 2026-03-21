#!/bin/bash
echo "Copying config to client..."
mkdir -p ~/.config ~/.config/alacritty ~/.config/nvim ~/.config/rio ~/.config/tmux
cp -r alacritty nvim rio tmux ~/.config/
cp .bash_profile .bashrc .gitconfig ~/
echo "Config copied."
if [[ -d ~/dotfiles/tmux/plugins/catppuccin/tmux ]]; then
  echo "Catppuccin theme for tmux installed, skipping clone."
else
  echo "Catppuccin theme for tmux not found, fetching..."
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
echo "Done!"

