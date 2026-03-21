#!/bin/bash

mkdir -p ~/.config
ln -s $(realpath -- ".bash_profile") ~/
ln -s $(realpath -- ".bashrc") ~/
ln -s $(realpath -- "tmux") ~/.config/tmux
ln -s $(realpath -- "nvim") ~/.config/nvim
ln -s $(realpath -- "rio") ~/.config/rio
ln -s $(realpath -- "alacritty") ~/.config/alacritty
