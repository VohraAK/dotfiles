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

# Install autosuggestions
echo ""
echo "Installing autosuggestions..."

# zsh-autosuggestions (via Homebrew)
if command -v brew >/dev/null 2>&1; then
    if brew list zsh-autosuggestions >/dev/null 2>&1; then
        echo "  zsh-autosuggestions already installed"
    else
        echo "  Installing zsh-autosuggestions..."
        brew install zsh-autosuggestions
    fi
else
    echo "  brew not found; install zsh-autosuggestions manually"
fi

# ble.sh (bash autosuggestions; requires git, make, gawk)
if [ -f "$HOME/.local/share/blesh/ble.sh" ]; then
    echo "  ble.sh already installed"
elif command -v git >/dev/null 2>&1 && command -v make >/dev/null 2>&1 && command -v gawk >/dev/null 2>&1; then
    echo "  Installing ble.sh..."
    BLE_TMP="$(mktemp -d)"
    git clone --recursive --depth 1 --shallow-submodules \
        https://github.com/akinomyoga/ble.sh.git "$BLE_TMP/ble.sh"
    make -C "$BLE_TMP/ble.sh" install PREFIX="$HOME/.local"
    rm -rf "$BLE_TMP"
else
    echo "  Skipping ble.sh (requires git, make, gawk)."
    echo "    On macOS: brew install gawk"
fi

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