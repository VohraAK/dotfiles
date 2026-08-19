# Starship prompt
eval "$(starship init bash)"

# Syntax highlighting (portable paths)
if [ -f /opt/homebrew/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
    source /opt/homebrew/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
elif [ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
    source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
elif [ -f /usr/local/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
    source /usr/local/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
fi

# Machine-specific config (not tracked in git)
[ -f ~/.local.bashrc ] && source ~/.local.bashrc