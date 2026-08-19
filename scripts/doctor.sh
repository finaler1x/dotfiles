#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
RED=$'\033[0;31m'
NC=$'\033[0m'

ok()      { printf "  ${GREEN}[ok]${NC}       %s\n" "$1"; }
missing() { printf "  ${YELLOW}[missing]${NC}  %s\n" "$1"; }
fail()    { printf "  ${RED}[error]${NC}    %s\n" "$1"; }
warn()    { printf "  ${YELLOW}[warning]${NC}  %s\n" "$1"; }

has() { command -v "$1" &>/dev/null; }

commands=(
  git curl stow zsh sheldon starship bat zoxide fzf rg fd dust duf xh
  lazygit lazydocker gh mise nvim tmux btop
)

packages=(tmux opencode nvim zsh ghostty bat lazygit lazydocker starship gh git mise proj herdr)

if [[ "$(uname)" == "Darwin" ]]; then
  packages+=(aerospace)
fi

echo "Checking commands..."
echo ""

missing_count=0
for cmd in "${commands[@]}"; do
  if has "$cmd"; then
    ok "$cmd"
  else
    missing "$cmd"
    missing_count=$((missing_count + 1))
  fi
done

echo ""
echo "Checking stow packages..."
echo ""

stow_failed=0
if has stow; then
  for pkg in "${packages[@]}"; do
    output=$(stow --dir="$DOTFILES_DIR" --target="$HOME" --no --restow "$pkg" 2>&1) || true

    if echo "$output" | grep -q "existing target"; then
      warn "$pkg has conflicts"
      echo "$output" | grep "existing target" | sed 's/.*existing target is neither a link nor a directory: /             ~\//'
      stow_failed=1
    elif echo "$output" | grep -q "ERROR"; then
      fail "$pkg → $output"
      stow_failed=1
    else
      ok "$pkg"
    fi
  done
else
  warn "stow not available; skipping package checks"
fi

echo ""
echo "Checking mise..."
echo ""

if has mise && [[ -f "$DOTFILES_DIR/mise/.config/mise/config.toml" ]]; then
  mise ls || warn "mise status unavailable; make apply will run mise install"
elif has mise; then
  warn "mise config missing"
else
  warn "mise not available; make apply will install it before running mise install"
fi

echo ""
if [[ $missing_count -eq 0 && $stow_failed -eq 0 ]]; then
  echo "Doctor complete. No command or stow issues found."
else
  echo "Doctor complete. Run 'make apply' to install missing tools and restow configs."
  if [[ $stow_failed -ne 0 ]]; then
    echo "Resolve stow conflicts with .opencode/runbooks/dotfiles-sync-conflicts.md."
  fi
fi
