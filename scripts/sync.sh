#!/usr/bin/env bash
set -uo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
RED=$'\033[0;31m'
NC=$'\033[0m'

ok()       { printf "  ${GREEN}[ok]${NC}       %s\n" "$1"; }
conflict() { printf "  ${YELLOW}[conflict]${NC} %s — remove the file and re-run\n" "$1"; }
fail()     { printf "  ${RED}[error]${NC}    %s\n" "$1"; }
warn()     { printf "  ${YELLOW}[warning]${NC}  %s\n" "$1"; }

restow_package() {
  local pkg="$1"
  local output
  output=$(stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg" 2>&1) || true

  if echo "$output" | grep -q "existing target"; then
    echo "$output" | grep "existing target" | sed 's/.*existing target is neither a link nor a directory: //' | while read -r file; do
      conflict "$pkg → ~/$file"
    done
    return 1
  elif echo "$output" | grep -q "ERROR"; then
    fail "$pkg → $output"
    return 1
  elif echo "$output" | grep -q "WARNING\|BUG"; then
    warn "$pkg"
    echo "$output" | while read -r line; do
      echo "             $line"
    done
    return 0
  else
    ok "$pkg"
    return 0
  fi
}

echo "Restowing packages..."
echo ""

failed=0
for pkg in tmux opencode nvim zsh ghostty bat lazygit lazydocker starship gh git mise; do
  restow_package "$pkg" || failed=1
done

echo ""
[[ $failed -eq 0 ]] && echo "All packages synced." || echo "Some packages had conflicts — resolve and re-run make sync."
