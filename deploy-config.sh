#!/bin/bash
echo "Config deployed."
if [[ -d ~/dotfiles/tmux/plugins/catppuccin/tmux ]]; then
  echo "Catppuccin theme for tmux installed, skipping clone."
else
  echo "Catppuccin theme for tmux not found, fetching..."
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
echo "Done!"

