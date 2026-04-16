# opencode config

This directory is managed by [stow](https://www.gnu.org/software/stow/) and symlinks into `~/.config/opencode/`.

## Setup

### 1. Stow the config

```sh
cd ~/dotfiles
stow opencode
```

### 2. Install plugins

Plugins are declared in `opencode.json` and installed automatically on first run. The following external binaries are required:

| Plugin | Binary | Install |
|---|---|---|
| `opencode-snip` | `snip` | `go install github.com/edouard-claude/snip/cmd/snip@latest` |

Make sure `$GOPATH/bin` (default `~/.local/share/go/bin`) is in your `$PATH`.

### 3. Verify

```sh
which snip   # should resolve
opencode     # plugins should load without warnings
```

## Structure

```
.config/opencode/
├── opencode.json     # main config: model, plugins, permissions, slash commands
├── AGENTS.md         # global rules applied to every agent
├── agents/           # per-agent system prompts
│   ├── builder.md
│   ├── debugger.md
│   ├── planner.md
│   ├── reviewer.md
│   └── sparring.md
└── skills/           # reusable skill fragments
    └── rtk-commands/
```

## Plugins

| Plugin | Purpose |
|---|---|
| `envsitter-guard` | Prevents secrets from leaking into context |
| `@tarquinen/opencode-dcp` | Message IDs for context compression |
| `@ramtinj95/opencode-tokenscope` | Token usage analytics |
| `opencode-mem` | Persistent memory across sessions |
| `@slkiser/opencode-quota` | Quota/cost tracking |
| `opencode-snip` | Prefixes bash commands with `snip` to cut token usage 60–90% |
| `opencode-notify` | Desktop notifications on completion |
| `opencode-handoff` | Hand off context to a new session |

## Slash Commands

| Command | Description |
|---|---|
| `/feature <name>` | Create a new git worktree + branch for a feature |
| `/feature-cleanup <name>` | Remove worktree and branch after merging |
| `/feature-status` | List active worktrees and their latest commits |
| `/plan <description>` | Analyze codebase and write an implementation plan |
| `/review` | Code review of current diff |
| `/debug <error>` | Diagnose and fix a failing check or test |
| `/spar <problem>` | Think through a technical problem before planning |

## Agent Workflow

Non-trivial tasks follow this pipeline:

```
@sparring (optional) → @planner → [review] → @builder → @reviewer
```

- Skip `@sparring` for clear, well-scoped tasks
- Skip `@planner` for trivial single-file changes
- Never skip `@reviewer`

Plans are saved to `.opencode/plans/` — check there before starting work.
