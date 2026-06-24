# Dotfiles Sync Conflicts

## Use when
`make sync` reports conflicts because real files exist where stow expects symlinks.

## Prerequisites
- GNU Stow installed
- Dotfiles repo cloned at `~/dotfiles`
- The conflicting package exists in `~/dotfiles/<package>/`

## Steps

1. Run dry-run to identify conflicts:
   ```
   stow --dir=~/dotfiles --target=$HOME -n <PACKAGE> 2>&1
   ```

2. Back up the conflicting real files:
   ```
   mkdir -p /tmp/dotfiles-backup-<PACKAGE>
   cp <CONFLICTING_FILES> /tmp/dotfiles-backup-<PACKAGE>/
   ```

3. Diff each conflicting file against the dotfiles version to check for unsaved changes:
   ```
   diff ~/dotfiles/<PACKAGE>/<RELATIVE_PATH> ~/<RELATIVE_PATH>
   ```

4. If the live file has changes you want to keep, copy them into the dotfiles version first:
   ```
   cp ~/<RELATIVE_PATH> ~/dotfiles/<PACKAGE>/<RELATIVE_PATH>
   ```

5. Remove the conflicting real files:
   ```
   rm <CONFLICTING_FILES>
   ```

6. Run stow:
   ```
   stow --dir=~/dotfiles --target=$HOME <PACKAGE>
   ```

## Checks

Verify symlinks point to dotfiles:
```
ls -la ~/<RELATIVE_PATH>
```

Each file should show `-> ../../dotfiles/<PACKAGE>/...` or similar.

Run `make sync` — should report `[ok]` for the package.

## Cleanup / Rollback

Backup is at `/tmp/dotfiles-backup-<PACKAGE>/`. To restore:
```
stow --dir=~/dotfiles --target=$HOME -D <PACKAGE>
cp /tmp/dotfiles-backup-<PACKAGE>/* <ORIGINAL_LOCATIONS>
```

## Pitfalls
- Always diff before removing. The live file may have evolved past the dotfiles version.
- Non-conflicting files in the same directory (e.g. `node_modules/`, plugin runtime files) are left in place by stow — this is fine.
- Stow won't touch files it didn't create. Extra files in the target directory coexist safely.
