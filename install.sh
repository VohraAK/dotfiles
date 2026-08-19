#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create config directory
mkdir -p "$HOME/.config"

# Link starship config
if [ -L "$HOME/.config/starship.toml" ]; then
    echo "~/.config/starship.toml already linked, skipping"
elif [ -f "$HOME/.config/starship.toml" ]; then
    echo "Backing up existing ~/.config/starship.toml to ~/.config/starship.toml.bak"
    mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.bak"
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
else
    ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
fi

# Function to safely link shell config
link_shell_config() {
    local source_file="$1"
    local target_file="$2"
    local name="$3"

    if [ -L "$target_file" ]; then
        echo "~$name already linked, skipping"
    elif [ -f "$target_file" ]; then
        echo "Backing up existing ~$name to ~$name.bak"
        mv "$target_file" "$target_file.bak"
        ln -sf "$source_file" "$target_file"
    else
        ln -sf "$source_file" "$target_file"
    fi
}

# Link shell configs
link_shell_config "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" ".zshrc"
link_shell_config "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" ".bashrc"

# Create local config templates if they don't exist
if [ ! -f "$HOME/.local.zshrc" ]; then
    cat > "$HOME/.local.zshrc" << 'EOF'
# Machine-specific config (NOT tracked in git)
# Add your conda, Android SDK, aliases, PATH exports here
EOF
    echo "Created ~/.local.zshrc template"
fi

if [ ! -f "$HOME/.local.bashrc" ]; then
    cat > "$HOME/.local.bashrc" << 'EOF'
# Machine-specific config (NOT tracked in git)
# Add your conda, Android SDK, aliases, PATH exports here
EOF
    echo "Created ~/.local.bashrc template"
fi

echo ""
echo "Done! Restart your shell or run:"
echo "  source ~/.zshrc   # for zsh"
echo "  source ~/.bashrc  # for bash"
echo ""
echo "Edit ~/.local.zshrc or ~/.local.bashrc for machine-specific config (not synced)"