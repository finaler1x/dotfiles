#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

stow_package() {
  local pkg="$1"
  echo "Stowing $pkg..."
  stow --dir="$DOTFILES_DIR" --target="$HOME" "$pkg"
}

stow_package tmux
stow_package opencode
stow_package nvim
stow_package zsh
stow_package ghostty
stow_package bat
stow_package lazygit
stow_package lazydocker
stow_package starship
stow_package gh
stow_package git
stow_package mise
