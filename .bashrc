# Only run under bash (zsh uses .zshrc)
[ -z "$BASH_VERSION" ] && return

# Starship prompt
eval "$(starship init bash)"

# Autosuggestions via ble.sh (if installed)
[ -f ~/.local/share/blesh/ble.sh ] && source ~/.local/share/blesh/ble.sh

# Machine-specific config (not tracked in git)
[ -f ~/.local.bashrc ] && source ~/.local.bashrc
