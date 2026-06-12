# LazyVim Cheat Sheet

The default leader key is `Space`.

## Core Keybindings
| Key | Action |
|-----|--------|
| `<leader>l` | Lazy Menu |
| `<leader>m` | Mason Menu (LSP/Linter/Formatter Manager) |
| `<leader>x` | Troubleshooting (Trouble) |
| `<leader>uh` | Toggle Inlay Hints |
| `<leader>uf` | Toggle Auto-format (Global) |
| `<leader>uF` | Toggle Auto-format (Buffer) |

## File Navigation and Search
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

## Buffers and Windows
| Key | Action |
|-----|--------|
| `[b` | Previous Buffer |
| `]b` | Next Buffer |
| `<leader>bb` | Switch Buffer |
| `<leader>bd` | Delete Buffer (Safe) |
| `<leader>bD` | Delete Buffer (Force) |
| `Ctrl-h/j/k/l` | Navigate between windows, including tmux panes |

## LSP and Coding
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

## Git
| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Git Blame Line |
| `<leader>gB` | Git Browse (Open in Browser) |
| `]h` | Next Hunk |
| `[h` | Previous Hunk |

## Editor Basics
| Key | Action |
|-----|--------|
| `<leader>qq` | Quit All |
| `<esc>` | Clear Search Highlight |
| `Ctrl-s` | Save File (if supported by terminal) |

*Note: Some keybindings depend on the installed plugins and their configuration.*
