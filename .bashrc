#
# ~/.bashrc
#

export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='nvim'
PS1='[\u@\h \W]\$ '
