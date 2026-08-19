#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create config directory
mkdir -p "$HOME/.config"

# Link starship config
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Link .zshrc
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "Done! Restart your shell or run: source ~/.zshrc"