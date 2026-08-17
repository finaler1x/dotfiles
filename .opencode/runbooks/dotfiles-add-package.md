# Add a New Stow Package

## Use when
Adding a new tool's configuration to the dotfiles repo.

## Prerequisites
- GNU Stow installed
- Dotfiles repo at `~/dotfiles`
- The tool is already installed and has config files to manage

## Steps

1. Create the package directory mirroring `$HOME`:
   ```
   mkdir -p ~/dotfiles/<PACKAGE>/.config/<TOOL>/
   ```
   The path after `<PACKAGE>/` must exactly mirror the path from `$HOME`. For example:
   - `~/.config/ghostty/config` → `ghostty/.config/ghostty/config`
   - `~/.gitconfig` → `git/.gitconfig`

2. Copy the existing config files into the package:
   ```
   cp ~/.config/<TOOL>/<FILES> ~/dotfiles/<PACKAGE>/.config/<TOOL>/
   ```

3. Add the package to `scripts/install.sh`:
   ```
   stow_package <PACKAGE>
   ```

4. Add the package to the `for` loop in `scripts/sync.sh`:
   ```
   for pkg in tmux opencode nvim ... <PACKAGE>; do
   ```

5. Add the package to the package list in `scripts/doctor.sh`:
   ```
   packages=(tmux opencode nvim ... <PACKAGE>)
   ```

6. Remove the original files (they'll be replaced by symlinks):
   ```
   rm ~/.config/<TOOL>/<FILES>
   ```

7. Stow the new package:
   ```
   stow --dir=~/dotfiles --target=$HOME <PACKAGE>
   ```

8. Commit:
   ```
   git add ~/dotfiles/<PACKAGE> ~/dotfiles/scripts/install.sh ~/dotfiles/scripts/sync.sh ~/dotfiles/scripts/doctor.sh
   git commit -m "feat: add <PACKAGE> dotfiles"
   ```

## Checks

Verify symlinks:
```
ls -la ~/.config/<TOOL>/
```

Run `make doctor` — the new package should report `[ok]` or an actionable conflict.

Run `make sync` — all packages should report `[ok]`.

Verify the tool still works with its config.

## Cleanup / Rollback

Remove stow symlinks and restore original files:
```
stow --dir=~/dotfiles --target=$HOME -D <PACKAGE>
cp ~/dotfiles/<PACKAGE>/.config/<TOOL>/<FILES> ~/.config/<TOOL>/
```

Revert the script changes and remove the package directory.

## Pitfalls
- `install.sh`, `sync.sh`, and `doctor.sh` must all be updated. Forgetting one means `make install`, `make sync`, or `make doctor` will skip the package.
- The directory structure under the package must exactly mirror `$HOME`. A wrong nesting level will stow files to the wrong place.
- Check `.stow-local-ignore` if the package name collides with an ignored pattern.
