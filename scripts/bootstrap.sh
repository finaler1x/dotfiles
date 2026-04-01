#!/usr/bin/env bash
set -euo pipefail

# ============================================
# Helpers
# ============================================
info()    { echo "[info] $*"; }
success() { echo "[ok]   $*"; }
skip()    { echo "[skip] $*"; }

has() { command -v "$1" &>/dev/null; }

# ============================================
# OS Detection
# ============================================
OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
  PLATFORM="mac"
elif [[ "$OS" == "Linux" ]]; then
  PLATFORM="linux"
  if has apt-get; then
    PKG_INSTALL="sudo apt-get install -y"
    PKG_UPDATE="sudo apt-get update -y"
  elif has pacman; then
    PKG_INSTALL="sudo pacman -S --noconfirm"
    PKG_UPDATE="sudo pacman -Sy"
  elif has dnf; then
    PKG_INSTALL="sudo dnf install -y"
    PKG_UPDATE="sudo dnf check-update || true"
  else
    echo "Unsupported package manager. Install packages manually." && exit 1
  fi
else
  echo "Unsupported OS: $OS" && exit 1
fi

# ============================================
# Package manager setup
# ============================================
if [[ "$PLATFORM" == "mac" ]]; then
  if ! has brew; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    skip "Homebrew already installed"
  fi
  install_pkg() { brew install "$@"; }
else
  $PKG_UPDATE
  install_pkg() { $PKG_INSTALL "$@"; }
fi

# ============================================
# Core dependencies
# ============================================
for pkg in git curl stow zsh; do
  if has "$pkg"; then
    skip "$pkg"
  else
    info "Installing $pkg..."
    install_pkg "$pkg"
  fi
done

# ============================================
# CLI tools
# ============================================
install_if_missing() {
  local cmd="$1"; shift
  if has "$cmd"; then
    skip "$cmd"
  else
    info "Installing $cmd..."
    "$@"
  fi
}

if [[ "$PLATFORM" == "mac" ]]; then
  install_if_missing sheldon   brew install sheldon
  install_if_missing delta     brew install git-delta
  install_if_missing starship  brew install starship
  install_if_missing bat       brew install bat
  install_if_missing zoxide    brew install zoxide
  install_if_missing fzf       brew install fzf
  install_if_missing lazygit     brew install lazygit
  install_if_missing lazydocker  brew install lazydocker
  install_if_missing gh          brew install gh
  install_if_missing mise        brew install mise
else
  install_if_missing sheldon     sh -c "$(curl --proto '=https' -sSfL https://rossmacarthur.github.io/install/crate.sh)" -- --crate sheldon --to ~/.local/bin
  install_if_missing delta       install_pkg git-delta
  install_if_missing starship    sh -c "$(curl -sS https://starship.rs/install.sh)" -- --yes
  install_if_missing bat         install_pkg bat
  install_if_missing zoxide      install_pkg zoxide
  install_if_missing fzf         install_pkg fzf
  install_if_missing lazygit     install_pkg lazygit
  install_if_missing lazydocker  sh -c "$(curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh)"
  install_if_missing gh          install_pkg gh
  install_if_missing mise        sh -c "$(curl https://mise.run)"
fi

# ============================================
# Done
# ============================================
echo ""
echo "Bootstrap complete. Run 'make install' to stow all configs."
