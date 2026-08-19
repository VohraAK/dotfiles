#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create config directory
mkdir -p "$HOME/.config"

# Link starship config
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Link shell configs
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"

echo "Done! Restart your shell or run: source ~/.zshrc (or ~/.bashrc)"