#!/bin/bash
echo "Stashing old config..."
chmod +x ./stash-config.sh
./stash-config.sh

echo "Linking in new config..."
chmod +x ./symlink-config.sh
./symlink-config.sh

hasZsh=$(zsh -v)
if [[ $? -ne 0 ]]; then
  echo "Shell configuration is only included for zsh - your shell will remain unconfigured by this script"
fi

if [[ ! -d ~/dotfiles/tmux/plugins/catppuccin/tmux ]]; then
  echo "Cloning catppuccin theme for tmux..."
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

echo "Done!"
echo "If you're satisfied you can remove your old config with remove-stashed-configs.sh"
