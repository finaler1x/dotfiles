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

5. Remove the original files (they'll be replaced by symlinks):
   ```
   rm ~/.config/<TOOL>/<FILES>
   ```

6. Stow the new package:
   ```
   stow --dir=~/dotfiles --target=$HOME <PACKAGE>
   ```

7. Commit:
   ```
   git add ~/dotfiles/<PACKAGE> ~/dotfiles/scripts/install.sh ~/dotfiles/scripts/sync.sh
   git commit -m "feat: add <PACKAGE> dotfiles"
   ```

## Checks

Verify symlinks:
```
ls -la ~/.config/<TOOL>/
```

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
- Both `install.sh` and `sync.sh` must be updated. Forgetting one means `make install` or `make sync` will skip the package.
- The directory structure under the package must exactly mirror `$HOME`. A wrong nesting level will stow files to the wrong place.
- Check `.stow-local-ignore` if the package name collides with an ignored pattern.
