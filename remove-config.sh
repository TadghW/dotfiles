#!/bin/bash
rm -r ~/.config/alacritty ~/.config/nvim ~/.config/rio ~/.config/tmux ~/.config/zsh
rm ~/.config/alacritty ~/.config/nvim ~/.config/rio ~/.config/tmux ~/.config/zsh
rm ~/.bash_profile ~/.bashrc ~/.gitconfig ~/.zshenv ~/.claude/CLAUDE.md
# remove only the skill links this repo deployed
for skill in "$(dirname "$0")"/claude-skills/*/; do
  [[ -d "$skill" ]] || continue
  rm ~/.claude/skills/"$(basename "$skill")"
done
