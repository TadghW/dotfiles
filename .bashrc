#
# ~/.bashrc
#

# Return here if not running in an interactive session
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias workspace='TERM=xterm-256color COLORTERM=truecolor ssh tadgh@192.168.0.6 -p 22222'
PS1='[\u@\h \W]\$ '
export PATH=$HOME/.local/bin:$PATH

eval "$(oh-my-posh init bash --config 'catppuccin_mocha')"
