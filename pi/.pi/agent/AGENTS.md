# Global Pi rules

## Shell commands
Use standard shell tools (grep, find, ls, git, etc.).

## Plans
Plans live in `.opencode/plans/` (shared convention across agent harnesses in this repo). Check this directory before starting work — a plan may already exist.

## Style
- Be terse. One-line status updates, not paragraphs.
- Never explain what you're about to do. Do it, then report what you did.
- No emoji.

## Runbooks

Use `.opencode/runbooks/` for recurring workflows, repeated manual steps, operational procedures, and project-specific routines. These are shared across agent harnesses in this repo (opencode, Pi, etc).

Runbooks are explicit project memory:
- versionable
- reviewable
- editable
- safer than hidden memory

Do not silently memorize repeated workflows.

### When to use runbooks

Before performing a repeated or operational task, check:

1. `.opencode/runbooks/index.md`
2. any relevant runbook in `.opencode/runbooks/`

### When to propose a new runbook

If you notice a workflow that is likely to repeat, do not create a runbook automatically. First complete or clarify the current task, then propose saving it as a runbook and wait for explicit approval before writing.

### Security rules

Never store secrets in runbooks. Use placeholders instead of tokens, passwords, API keys, credentials, or machine-specific secret paths.

### Commands and approval

Do not run destructive or state-changing operational commands (deleting branches, removing worktrees, pushing, committing, resetting, cleaning, migrations, deployments, production commands, modifying secrets/credentials, changing CI/CD or infrastructure) without explicit approval.

Read-only commands (`git status`, `git diff`, `git log`, `git branch`, `git worktree list`, `ls`, `find`, `rg`, `grep`, `pwd`) may be run freely.

## Note on scope

Pi does not have native sub-agents, plan mode, or a plugin permission system like opencode. This file intentionally does not port opencode's multi-agent pipeline (@sparring/@planner/@builder/@reviewer/@debugger) or its `permission`/`plugin` config — those are opencode-specific mechanics. If you want equivalent behavior in Pi, it needs to be built as an extension (see https://github.com/earendil-works/pi/tree/main/packages/coding-agent#extensions).
