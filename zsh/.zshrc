setopt autocd
setopt interactive_comments
setopt prompt_subst
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

plugins=(git)
autoload -Uz vcs_info
autoload -Uz colors && colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr ' %F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr ' %F{yellow}*%f'
zstyle ':vcs_info:git:*' formats ' %B%F{white}(%f%F{red}%b%c%u%F{white})%f'
zstyle ':vcs_info:git:*' actionformats ' %B%F{white}(%f%F{red}%b%c%u %F{yellow}[%a]%f%F{white})%f'

precmd() {
  vcs_info
}

PROMPT='%F{magenta}%D{%H:%M}%f > %F{green}%n@%m%f > %B%F{blue}%~%f%b${vcs_info_msg_0_}%f%b > '

export COLORTERM=truecolor

if [[ ! -d ~/.config/zsh/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ~/.config/zsh/plugins/zsh-sage ]]; then
  git clone https://github.com/UtsavMandal2022/zsh-sage ~/.config/zsh/plugins/zsh-sage
fi

source ~/.config/zsh/plugins/zsh-sage/zsh-sage.plugin.zsh
export ZSH_SAGE_AI_ENABLED=true

# zsh-sage opens a persistent sqlite3 coprocess; silence zsh's "[n] pid"
# job announcement while it starts up. Only restore `monitor` if it was on to
# begin with — a shell with no controlling terminal cannot enable it, and
# `setopt monitor` would error there.
if [[ -o monitor ]]; then
  unsetopt monitor
  source ~/.config/zsh/plugins/zsh-sage/zsh-sage.plugin.zsh
  setopt monitor
else
  source ~/.config/zsh/plugins/zsh-sage/zsh-sage.plugin.zsh
fi

source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

alias reload-shell="source ~/.config/zsh/.zshrc"
alias modify-shell="nvim ~/.config/zsh/.zshrc"
