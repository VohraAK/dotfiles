# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Compinit with 24-hour cache
autoload -Uz compinit
if [ -n "$ZSH_COMPDUMP" ]; then
    compdump="$ZSH_COMPDUMP"
else
    compdump="${ZDOTDIR:-$HOME}/.zcompdump"
fi
if [ -f "$compdump" ] && [ "$(find "$compdump" -mtime -1 2>/dev/null)" ]; then
    compinit -C
else
    compinit
fi

# Source autosuggestions (apt path for Linux, Homebrew for macOS)
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Tab: accept suggestion if present, otherwise native completion
zle -N autosuggest-accept-or-complete
autosuggest-accept-or-complete() {
    if [[ -n "$POSTDISPLAY" ]]; then
        zle autosuggest-accept
    else
        zle expand-or-complete
    fi
}
bindkey '^I' autosuggest-accept-or-complete

# Initialize Starship prompt
eval "$(starship init zsh)"

# Source syntax highlighting (must be last, use compiled .zwc if available)
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh.zwc ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh.zwc
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi