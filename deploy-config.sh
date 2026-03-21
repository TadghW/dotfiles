#!/bin/bash

chmod +x ./stash-config.sh ./symlink-config.sh
./stash-config.sh
./symlink-config.sh
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
