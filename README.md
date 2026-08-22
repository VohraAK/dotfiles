# Dotfiles

Portable shell configuration for zsh + Starship prompt.

## Contents

- `.zshrc` - Minimal zsh config with Starship, syntax highlighting, conda, Android SDK
- `.config/starship.toml` - Starship prompt configuration

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
source ~/.zshrc
```

## Requirements

- **zsh** (default on macOS)
- **Starship** - `brew install starship` (macOS) / `curl -sS https://starship.rs/install.sh | sh` (Linux)
- **zsh-syntax-highlighting** - `brew install zsh-syntax-highlighting` (macOS)
- **zsh-autosuggestions** - `brew install zsh-autosuggestions` (macOS, fish-like suggestions for zsh)
- **ble.sh** - bash autosuggestions; installed by `install.sh` (requires `git`, `make`, `gawk` — `brew install gawk` on macOS)

## Starship Prompt Features

- Time (`[HH:MM]`)
- Hostname (`[hostname]`)
- Current directory (truncated to 1 segment)
- Git branch + status + metrics (added lines)
- Green/red prompt character based on last exit code

## Customization

Edit `.config/starship.toml` to modify prompt format, colors, or modules.