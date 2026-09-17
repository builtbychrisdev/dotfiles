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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/chris/.lmstudio/bin"
# End of LM Studio CLI section

