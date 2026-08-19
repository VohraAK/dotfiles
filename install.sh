#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false

# Parse args
for arg in "$@"; do
    case $arg in
        --force|-f) FORCE=true ;;
        --help|-h)
            echo "Usage: ./install.sh [--force|-f]"
            echo "  --force, -f    Overwrite existing configs without backup"
            exit 0
            ;;
        *) echo "Unknown option: $arg"; exit 1 ;;
    esac
done

echo "Installing dotfiles from $DOTFILES_DIR"
$FORCE && echo "  FORCE mode: overwriting without backup"

# Create config directory
mkdir -p "$HOME/.config"

# Function to link with optional force
link_file() {
    local source="$1"
    local target="$2"
    local name="$3"

    if [ -L "$target" ]; then
        if $FORCE; then
            rm -f "$target"
            ln -sf "$source" "$target"
            echo "  Replaced symlink: ~$name"
        else
            echo "  ~$name already linked, skipping"
        fi
    elif [ -f "$target" ]; then
        if $FORCE; then
            rm -f "$target"
            ln -sf "$source" "$target"
            echo "  Overwrote: ~$name"
        else
            mv "$target" "$target.bak"
            ln -sf "$source" "$target"
            echo "  Backed up & linked: ~$name (~$name.bak)"
        fi
    else
        ln -sf "$source" "$target"
        echo "  Linked: ~$name"
    fi
}

# Link starship config
link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml" "/.config/starship.toml"

# Link shell configs
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc" "/.zshrc"
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc" "/.bashrc"

# Create local config templates if they don't exist (never overwrite)
if [ ! -f "$HOME/.local.zshrc" ]; then
    cat > "$HOME/.local.zshrc" << 'EOF'
# Machine-specific config (NOT tracked in git)
# Add your conda, Android SDK, aliases, PATH exports here
EOF
    echo "  Created ~/.local.zshrc template"
fi

if [ ! -f "$HOME/.local.bashrc" ]; then
    cat > "$HOME/.local.bashrc" << 'EOF'
# Machine-specific config (NOT tracked in git)
# Add your conda, Android SDK, aliases, PATH exports here
EOF
    echo "  Created ~/.local.bashrc template"
fi

echo ""
echo "Done! Restart your shell or run:"
echo "  source ~/.zshrc   # for zsh"
echo "  source ~/.bashrc  # for bash"
echo ""
echo "Edit ~/.local.zshrc or ~/.local.bashrc for machine-specific config (not synced)"