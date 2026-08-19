# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Each package is a directory that mirrors the `$HOME` structure — stow creates symlinks so editing files in this repo is the same as editing them directly.

## Packages

| Package | Symlinked to |
|---------|-------------|
| `nvim` | `~/.config/nvim/` ([Cheat Sheets](cheat-sheets/README.md)) |
| `tmux` | `~/.config/tmux/tmux.conf` |
| `zsh` | `~/.zshrc`, `~/.zsh_aliases`, `~/.config/sheldon/plugins.toml` |
| `starship` | `~/.config/starship.toml` |
| `ghostty` | `~/.config/ghostty/config` |
| `bat` | `~/.config/bat/config` |
| `lazygit` | `~/.config/lazygit/config.yml` |
| `lazydocker` | `~/.config/lazydocker/config.yml` |
| `gh` | `~/.config/gh/config.yml` |
| `git` | `~/.gitconfig` |
| `mise` | `~/.config/mise/config.toml` |
| `opencode` | `~/.config/opencode/opencode.json` |
| `aerospace` (macOS only) | `~/.config/aerospace/aerospace.toml` |

## Setup

Fresh clone:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
make bootstrap
make install
```

On an existing machine after pulling updates, inspect and apply changes with:

```bash
make doctor
make apply
```

For a symlink-only update, run:

```bash
make sync
```

## Commands

### `make bootstrap`
Installs all dependencies (sheldon, starship, bat, zoxide, fzf, rg, fd, dust, duf, xh, lazygit, lazydocker, gh, git-delta, mise, nvim, tmux, btop). Safe to run on a fresh machine — skips anything already installed.

> **Note (Ubuntu/Debian):** `fd` is installed as `fdfind`. Bootstrap automatically creates a `~/.local/bin/fd` symlink. Make sure `~/.local/bin` is in your `PATH`.

### `make install`
Stows all packages by creating symlinks from `$HOME` into this repo. Run once after cloning. Aborts on conflicts — if a config file already exists at the target path, remove it first and re-run.

### `make doctor`
Checks expected commands, stow dry-run status, and mise state without installing tools or changing symlinks. Run this before applying updates on a non-fresh machine.

### `make apply`
Runs `make bootstrap`, restows dotfiles, runs `mise install` for configured runtimes (`node`, `python`, `go`, `java`), then runs `make doctor`. Use this after pulling updates on an existing machine.

### `make sync`
Restows all packages. Use this for a quick symlink-only update after adding files to a package.

## Shell features

| Feature | How |
|---------|-----|
| `Ctrl-t` | Fuzzy file finder (fd-backed) |
| `Ctrl-r` | Fuzzy history search |
| `Alt-c` | Fuzzy cd into directory |
| `zi` | Interactive zoxide directory jump |
| `z <dir>` | Jump to frecency-matched directory |

## tmux popups

| Key | Action |
|-----|--------|
| `Prefix + g` | lazygit |
| `Prefix + D` | lazydocker |
| `Prefix + B` | btop |

## Machine-specific config

Copy `.zshrc.local.example` to `~/.zshrc.local` for overrides that shouldn't be tracked (work proxies, GPU workarounds, extra PATH entries). This file is gitignored.

## Adding a new package

1. Create a directory named after the package (e.g. `foo/`)
2. Mirror the target path inside it (e.g. `foo/.config/foo/config`)
3. Add `stow_package foo` to `scripts/install.sh`
4. Add `foo` to the list in `scripts/sync.sh`
5. Add `foo` to the package list in `scripts/doctor.sh`
6. Run `make doctor` and `make sync`
