# Modify Opencode Config

## Use when
Changing opencode agents, slash commands, plugins, permissions, or AGENTS.md.

## Prerequisites
- Dotfiles repo at `~/dotfiles`
- Opencode package is stowed (`~/.config/opencode/` files are symlinks to dotfiles)

## Steps

1. Edit the file in the **dotfiles repo**, not the live symlink:
   - Config: `~/dotfiles/opencode/.config/opencode/opencode.json`
   - Global rules: `~/dotfiles/opencode/.config/opencode/AGENTS.md`
   - Agent definitions: `~/dotfiles/opencode/.config/opencode/agents/<NAME>.md`
   - Skills: `~/dotfiles/opencode/.config/opencode/skills/<NAME>/SKILL.md`

2. If adding a new agent file or skill directory, run stow to create the symlink:
   ```
   make sync
   ```
   Editing existing files does not require restowing — the symlink already points to the dotfiles copy.

3. Restart opencode. Config is loaded at startup and not hot-reloaded.

4. Commit the change:
   ```
   git -C ~/dotfiles add opencode/
   git -C ~/dotfiles commit -m "chore: <DESCRIPTION>"
   ```

## Checks

Verify the symlink points to dotfiles:
```
ls -la ~/.config/opencode/<CHANGED_FILE>
```

After restarting opencode, verify the change took effect (e.g. new agent appears, command works, permission applies).

## Cleanup / Rollback

Revert the dotfiles commit:
```
git -C ~/dotfiles revert HEAD
```

Restart opencode.

## Pitfalls
- Never edit the live files at `~/.config/opencode/` directly. They are symlinks — edits go through, but `git status` in the dotfiles repo won't show changes if you used an editor that replaces the file instead of writing through the symlink.
- opencode validates `opencode.json` strictly. A malformed file prevents startup. Use `OPENCODE_DISABLE_PROJECT_CONFIG=1` to recover.
- Adding new files (agents, skills) requires `make sync` to create symlinks. Editing existing ones does not.
- The `plugin` array uses npm specifiers. After changing plugins, opencode installs them on next start — this requires network access.
