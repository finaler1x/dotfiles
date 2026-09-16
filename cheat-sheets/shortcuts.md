# Shortcuts

Quick reference for all tools in this setup.

---

## Firefox

| Key | Action |
|-----|--------|
| `Ctrl-l` | Focus address bar |
| `Ctrl-t` | New tab |
| `Ctrl-w` | Close current tab |
| `Ctrl-Shift-t` | Reopen closed tab |
| `Ctrl-Tab` | Next tab |
| `Ctrl-Shift-Tab` | Previous tab |
| `Ctrl-r` | Reload page |
| `Ctrl-Shift-r` | Hard reload |
| `Ctrl-d` | Bookmark current page |
| `Ctrl-h` | Open history sidebar |
| `Ctrl-j` | Open downloads |
| `Ctrl-Shift-p` | New private window |
| `/` | Find in page |

---

## KDE Plasma

| Key | Action |
|-----|--------|
| `Alt-Space` | Open KRunner |
| `Alt-Tab` | Switch windows |
| `Meta-L` | Lock session |
| `Print` | Screenshot with Spectacle |
| `Meta-Shift-S` | Rectangular region screenshot |
| `Ctrl-Alt-Del` | Logout / shutdown screen |
| `Meta + drag` | Move window |
| `Meta + right-drag` | Resize window |

---

## Hyprland

`Super` is the Windows/Meta key.

| Key | Action |
|-----|--------|
| `Super-Q` | Open Ghostty (Hyprland's standard terminal shortcut) |
| `Super-C` | Close active window |
| `Super-M` | Exit Hyprland and return to SDDM |
| `Super-E` | Open Dolphin |
| `Super-V` | Toggle floating for the active window |
| `Super-R` | Open Wofi (Hyprland's standard launcher shortcut) |
| `Super-P` | Toggle pseudotiling |
| `Super-J` | Toggle the Dwindle split direction |
| `Super-Left/Right/Up/Down` | Move focus in that direction |
| `Super-1` … `Super-0` | Switch to workspace 1 … 10 |
| `Super-Shift-1` … `Super-Shift-0` | Move active window to workspace 1 … 10 |
| `Super-S` | Toggle the `magic` special workspace |
| `Super-Shift-S` | Move active window to the `magic` special workspace |
| `Super-Mouse wheel` | Cycle through existing workspaces |
| `Super + left-drag` | Move window |
| `Super + right-drag` | Resize window |
| `Volume Up/Down` | Raise or lower output volume |
| `Mute` | Toggle output mute |
| `Mic Mute` | Toggle microphone mute |
| `Brightness Up/Down` | Raise or lower display brightness |
| `Media Next/Previous` | Select the next or previous media item |
| `Media Play/Pause` | Toggle media playback |

---

## TTY and graphical-session recovery

| Key / command | Action |
|---------------|--------|
| `Ctrl-Alt-F3` | Switch from a graphical session to TTY 3 |
| `Ctrl-Alt-F1` or `Ctrl-Alt-F2` | Return to the graphical session; assignment can vary |
| `exit` | Log out of the current TTY |
| `sudo systemctl restart sddm` | Restart the login screen if Hyprland remains black; terminates the current graphical session |

At SDDM, select **Plasma (Wayland)** for the known-working KDE session or **Hyprland** for the test session.

---

## herdr

`ctrl+alt` shortcuts use no prefix. `prefix` shortcuts require `ctrl+b` first (shared with tmux).

| Key | Action |
|-----|--------|
| `Ctrl-Shift-Left` / `prefix+h` | Focus pane left |
| `Ctrl-Shift-Down` / `prefix+j` | Focus pane down |
| `Ctrl-Shift-Up` / `prefix+k` | Focus pane up |
| `Ctrl-Shift-Right` / `prefix+l` | Focus pane right |
| `Ctrl-Alt-[` / `prefix+p` | Previous tab |
| `Ctrl-Alt-]` / `prefix+n` | Next tab |
| `Ctrl-Alt-C` / `prefix+c` | New tab |
| `Ctrl-Alt-D` / `prefix+v` | Split vertical |
| `Ctrl-Alt-Shift-D` / `prefix+-` | Split horizontal |
| `Ctrl-Alt-Z` / `prefix+z` | Zoom pane |
| `prefix+w` | Open workspace picker (requires `Ctrl-b` prefix) |

---

## tmux

Prefix is `Ctrl-b`. Mouse support enabled; panes and windows start at `1`; splits open in current pane's working directory.

| Key | Action |
|-----|--------|
| `Ctrl-b` | Prefix |
| `Ctrl-b c` | New window |
| `Ctrl-b n` | Next window |
| `Ctrl-b p` | Previous window |
| `Ctrl-b ,` | Rename window |
| `Ctrl-b d` | Detach session |
| `Ctrl-b \|` | Split vertically in current directory |
| `Ctrl-b -` | Split horizontally in current directory |
| `Ctrl-b x` | Kill current pane |
| `Ctrl-b z` | Zoom current pane |
| `Ctrl-b [` | Enter copy mode |
| `Ctrl-h/j/k/l` | Move between Neovim windows and tmux panes |
| `Prefix + I` | Install tmux plugins with TPM |
| `Prefix + g` | Open lazygit popup |
| `Prefix + D` | Open lazydocker popup |
| `Prefix + B` | Open btop popup |

---

## LazyVim

Leader key is `Space`.

### Core

| Key | Action |
|-----|--------|
| `<leader>l` | Lazy Menu |
| `<leader>m` | Mason Menu (LSP/Linter/Formatter Manager) |
| `<leader>x` | Troubleshooting (Trouble) |
| `<leader>uh` | Toggle Inlay Hints |
| `<leader>uf` | Toggle Auto-format (Global) |
| `<leader>uF` | Toggle Auto-format (Buffer) |

### File Navigation and Search

| Key | Action |
|-----|--------|
| `<leader>e` | Explorer (Neo-tree) |
| `<leader>ff` | Find Files (Root Dir) |
| `<leader>fF` | Find Files (CWD) |
| `<leader>fr` | Recent Files |
| `<leader>sg` | Live Grep (Root Dir) |
| `<leader>/` | Search in Files (Grep) |
| `<leader>sa` | Auto-commands |
| `<leader>sb` | Buffer Search |
| `<leader>sc` | Command History |
| `<leader>sk` | Search Keymaps |
| `<leader>ft` | Toggle Floating Terminal |
| `<leader><space>` | Find Files (Root Dir) |

### Buffers and Windows

| Key | Action |
|-----|--------|
| `[b` | Previous Buffer |
| `]b` | Next Buffer |
| `<leader>bb` | Switch Buffer |
| `<leader>bd` | Delete Buffer (Safe) |
| `<leader>bD` | Delete Buffer (Force) |
| `Ctrl-h/j/k/l` | Navigate between windows, including tmux panes |

### LSP and Coding

| Key | Action |
|-----|--------|
| `K` | Hover Documentation |
| `gd` | Go to Definition |
| `gr` | References (Trouble/Telescope) |
| `gI` | Go to Implementation |
| `gy` | Go to Type Definition |
| `<leader>ca` | Code Action |
| `<leader>cr` | Rename Symbol |
| `]d` | Next Diagnostic |
| `[d` | Previous Diagnostic |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Git Blame Line |
| `<leader>gB` | Git Browse (Open in Browser) |
| `]h` | Next Hunk |
| `[h` | Previous Hunk |

### Editor Basics

| Key | Action |
|-----|--------|
| `<leader>qq` | Quit All |
| `<esc>` | Clear Search Highlight |
| `Ctrl-s` | Save File (if supported by terminal) |

*Note: Some keybindings depend on installed plugins and their configuration.*
