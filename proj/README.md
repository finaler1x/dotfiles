# proj — tmux project sessionizer

Opens a project in a dedicated tmux session with a fixed 3-pane layout.
Reattaches if the session already exists.

## Usage

    proj <path>          Open/reattach project at <path>
    proj --help          Show this help

## Layout

    ┌──────────────┬───────────┐
    │              │ opencode  │
    │    nvim      ├───────────┤
    │              │   shell   │
    └──────────────┴───────────┘
    60% left          40% right

## Session naming

Session name = basename of the resolved path.
Example: `proj ~/Projects/my-app` → session name `my-app`

## fzf session switcher

Bind in tmux.conf with (suggested key: `C-f`):

    bind C-f display-popup -E "\
      tmux list-sessions -F '#{session_name}' | \
      fzf --prompt='session: ' | \
      xargs -r tmux switch-client -t"

Or use the zsh widget bound to a key (see zsh/.zsh_functions).

## tmux-resurrect / continuum

Already configured. Sessions are auto-saved every 15 min and restored on
tmux server start. Run `prefix + I` once if plugins aren't yet installed.

## Installation

    cd ~/dotfiles
    make install        # or: stow --target=$HOME proj
