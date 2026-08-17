#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

phase() {
  echo ""
  echo "==> $1"
}

has() { command -v "$1" &>/dev/null; }

phase "Installing missing CLI dependencies"
bash "$DOTFILES_DIR/scripts/bootstrap.sh"

phase "Restowing dotfiles"
if ! bash "$DOTFILES_DIR/scripts/sync.sh"; then
  echo ""
  echo "Stow conflicts must be resolved manually. See .opencode/runbooks/dotfiles-sync-conflicts.md."
  exit 1
fi

phase "Installing mise tools"
if has mise && [[ -f "$DOTFILES_DIR/mise/.config/mise/config.toml" ]]; then
  mise install
elif has mise; then
  echo "mise config missing; skipping mise install."
else
  echo "mise missing after bootstrap; skipping mise install."
fi

phase "Checking final state"
bash "$DOTFILES_DIR/scripts/doctor.sh"

echo ""
echo "Apply complete."
