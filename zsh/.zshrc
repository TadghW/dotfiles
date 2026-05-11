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
zstyle ':vcs_info:git:*' stagedstr ' %f{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr ' %f{yellow}*%f'
zstyle ':vcs_info:git:*' formats ' on %b%f{red}%b%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' on %b%f{red}%b %f{yellow}[%a]%f%c%u'

precmd() {
  vcs_info
}

prompt='%b%f{green}%n@%m%f%b in %b%f{blue}%~%f%b${vcs_info_msg_0_} > '

export COLORTERM=truecolor

if [[ ! -d ~/.config/zsh/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ~/.config/zsh/plugins/zsh-sage ]]; then
  git clone https://github.com/UtsavMandal2022/zsh-sage ~/.config/zsh/plugins/zsh-sage
fi

source ~/.config/zsh/plugins/zsh-sage/zsh-sage.plugin.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
