# ---- history ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups hist_ignore_space share_history inc_append_history

# ---- behaviour ----
setopt auto_cd interactive_comments
unsetopt nomatch          # don't nuke the whole command when a glob matches nothing

# ---- completion ----
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ---- aliases ----
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'

# ---- plugins (order matters: syntax-highlighting LAST) ----
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- prompt ----
eval "$(starship init zsh)"
