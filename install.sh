#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
    PKG_MGR="brew"
elif [ "$OS" = "Linux" ]; then
    PKG_MGR="apt"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."
if [ "$PKG_MGR" = "apt" ]; then
    sudo apt update && sudo apt install -y zsh-autosuggestions zsh-syntax-highlighting curl
    # Byte-compile syntax highlighting for faster loading on slow SD cards
    echo "Compiling zsh-syntax-highlighting..."
    zsh -c 'zcompile /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' 2>/dev/null || true
elif [ "$PKG_MGR" = "brew" ]; then
    brew install zsh-autosuggestions zsh-syntax-highlighting curl
fi

# Install Starship non-interactively
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Make zsh the login shell (otherwise SSH sessions stay on bash)
ZSH_PATH="$(command -v zsh)"
if [ "$(basename "${SHELL:-}")" != "zsh" ] && [ -n "$ZSH_PATH" ]; then
    echo "Setting login shell to zsh..."
    sudo chsh -s "$ZSH_PATH" "$USER" || echo "chsh failed; run: chsh -s $ZSH_PATH"
fi

# Create config directory
mkdir -p "$HOME/.config"

# Link shell configs
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

echo ""
echo "Done! Restart your shell or run:"
echo "  source ~/.zshrc"