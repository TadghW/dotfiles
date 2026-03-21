#!/bin/bash
mkdir -p ~/.config ~/.config/alacritty ~/.config/nvim ~/.config/rio ~/.config/tmux
cp -r alacritty nvim rio tmux ~/.config/
cp .bash_profile .bashrc .gitconfig ~/
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
