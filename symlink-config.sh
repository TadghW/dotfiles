#!/bin/bash

mkdir -p ~/.config ~/.config/tmux ~/.config/nvim ~/.config/alacritty ~/.config/rio
ln -s $(realpath ".bash_profile") ~/
ln -s $(realpath ".bashrc") ~/
ln -s $(realpath ".gitconfig") ~/
ln -s $(realpath "tmux") ~/.config/tmux
ln -s $(realpath "nvim") ~/.config/nvim
ln -s $(realpath "rio") ~/.config/rio
ln -s $(realpath "alacritty") ~/.config/alacritty
