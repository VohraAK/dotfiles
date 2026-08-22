# Source autosuggestions from apt path
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Initialize completion system
autoload -U compinit && compinit

# Initialize Starship prompt
eval "$(starship init zsh)"

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

# Source syntax highlighting from apt path (must be last)
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi