# ── history ───────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

# ── behaviour ─────────────────────────────────────────────
setopt AUTO_CD INTERACTIVE_COMMENTS
bindkey -e

# ── completion ────────────────────────────────────────────
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ── env ───────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

# ── aliases ───────────────────────────────────────────────
alias vim='nvim'
alias vi='nvim'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias ..='cd ..'
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# ── plugins (syntax-highlighting must be last) ────────────
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#665c54'

# ── prompt ────────────────────────────────────────────────
eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/chris/.lmstudio/bin"
# End of LM Studio CLI section

