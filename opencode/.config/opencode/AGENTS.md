# Global opencode rules

## Shell commands
Use standard shell tools (grep, find, ls, git, etc.).

## Agent workflow

### Full pipeline (non-trivial tasks)
1. @sparring — discuss, challenge, decide (optional but recommended for anything architectural)
2. @planner — find relevant files, write a plan, wait for approval
3. (you review and approve the plan)
4. @builder — implement from plan
5. @reviewer — audit the diff
6. If @reviewer requests changes → back to @builder, then @reviewer again
7. If architectural issues surface in review → back to @sparring

### When to skip steps
- Skip @sparring for clear, well-scoped tasks
- Skip @planner for trivial single-file changes
- Never skip @reviewer

### Re-entry points
- @reviewer flags blockers → @builder fixes → @reviewer again
- @reviewer flags architectural issues → @sparring → @planner → @builder → @reviewer
- @builder hits a failing check → @debugger diagnoses → @builder continues
- @builder hits unexpected complexity → stop, go back to @planner

## Plans
Plans live in `.opencode/plans/`. Check this directory before starting work — a plan may already exist.

## Style
- Be terse. One-line status updates, not paragraphs.
- Never explain what you're about to do. Do it, then report what you did.
- No emoji except in reviewer output where 🔴🟡🟢 are part of the format.

## Runbooks

Use `.opencode/runbooks/` for recurring workflows, repeated manual steps, operational procedures, and project-specific handgriffe.

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

Use a runbook when the task matches an existing documented workflow.

Examples:
- feature worktree setup
- release steps
- deployment checklist
- recurring debugging flow
- database migration procedure
- local project setup
- test/review workflow
- cleanup procedure
- environment-specific project routine

### When to propose a new runbook

If you notice a workflow that is likely to repeat, do not create a runbook automatically.

First complete or clarify the current task.

Then say:

"Das sieht nach einem wiederholbaren Workflow aus. Soll ich daraus ein Runbook unter `.opencode/runbooks/<short-kebab-case-name>.md` machen?"

Only create or update a runbook after explicit user approval.

### What a runbook must contain

Every runbook must use this structure:

```markdown
# <Runbook Name>

## Use when
Describe when this workflow should be used.

## Prerequisites
List required state, tools, branches, environment, permissions, or assumptions.

## Steps
Concrete ordered steps.

Use commands only when they are safe and necessary.
Prefer placeholders for variable values.

Example:
`git worktree add ../<repo>-<feature-name> feature/<feature-name>`

## Checks
How to verify the workflow succeeded.

Include commands and expected behaviour.

## Cleanup / Rollback
How to undo, clean up, or recover if something goes wrong.

If rollback is not possible, say so explicitly.

## Pitfalls
Known traps, edge cases, and things not to do.
```

### Security rules

Never store secrets in runbooks.

Do not include:
- tokens
- passwords
- API keys
- private keys
- `.env` contents
- credentials
- machine-specific secret paths
- private customer data
- production-only values

Use placeholders instead:
- `<TOKEN>`
- `<API_KEY>`
- `<ENV>`
- `<PROJECT>`
- `<BRANCH>`
- `<FEATURE_NAME>`
- `<USER>`
- `<HOST>`

If a workflow requires a secret, write:
"Use the appropriate secret from the approved local environment. Do not paste it into this file."

### Runbook index

Maintain `.opencode/runbooks/index.md`.

The index should list available runbooks:

```markdown
# Runbooks

- `feature-worktree.md` — start and clean up isolated feature worktrees
- `debugging.md` — reproduce and isolate failing checks
- `release.md` — release checklist
- `project-setup.md` — local project setup
```

When creating a new runbook, update the index too.

Only update the index after explicit approval to create or update the runbook.

### Agent behaviour for runbooks

#### @sparring

Use runbooks only as context for discussion.

If a decision creates a repeatable workflow, suggest saving it as a runbook after the decision summary.

Do not create or edit runbooks.

#### @planner

Before planning repeated operational work, check `.opencode/runbooks/index.md`.

If a relevant runbook exists:
- reference it in the plan
- adapt only the task-specific parts
- do not duplicate the full runbook into the plan

If no runbook exists and the workflow is likely to repeat:
- mention this under `## Risks` or `## Out of scope`
- suggest creating a runbook after the plan

Planner may create or update runbooks only after explicit user approval.

#### @builder

Before implementing repeated operational steps, check whether the plan references a runbook.

Follow the runbook exactly unless the plan says otherwise.

If the runbook is outdated or wrong:
- stop
- explain the mismatch
- ask whether @planner should update the plan or runbook

Builder must not silently update runbooks during implementation.

After completing a task, if a repeated workflow emerged, say:

"Das sieht nach einem wiederholbaren Workflow aus. Soll ich daraus ein Runbook unter `.opencode/runbooks/<short-kebab-case-name>.md` machen?"

#### @debugger

If a failure pattern repeats, recommend documenting it as a debugging runbook.

Do not edit runbooks.

Example:
"Diese Failure-Klasse scheint wiederkehrend zu sein. Empfehlung: als `.opencode/runbooks/debug-<topic>.md` dokumentieren."

#### @reviewer

When reviewing changes involving runbooks:
- verify they do not contain secrets
- verify commands are safe and scoped
- verify placeholders are used for environment-specific values
- verify the index is updated when a runbook is added
- flag stale or misleading runbook steps as blocking if they could cause damage

### Commands and approval

Agents must not run destructive or state-changing operational commands from a runbook without approval.

Approval is required for:
- deleting branches
- removing worktrees
- pushing
- committing
- resetting
- cleaning
- migrations
- deployments
- production commands
- modifying secrets or credentials
- changing CI/CD or infrastructure

Read-only commands may be run according to permissions:
- `git status`
- `git diff`
- `git log`
- `git branch`
- `git worktree list`
- `ls`
- `find`
- `rg`
- `grep`
- `pwd`

### Runbook creation flow

When asked to create a runbook:

1. Propose the filename:
   `.opencode/runbooks/<short-kebab-case-name>.md`

2. Summarize what will be saved.

3. Ask for approval before writing.

4. After approval:
   - create or update the runbook
   - update `.opencode/runbooks/index.md`
   - report the files changed

5. End with:
   "Runbook saved to `.opencode/runbooks/<name>.md`."

### Runbook quality bar

A good runbook is:
- short
- concrete
- safe
- repeatable
- project-specific
- free of secrets
- clear about verification
- clear about rollback

Do not create generic tutorials.
Do not write long explanations.
Do not include unrelated background.
Do not include speculative steps.

Runbooks are for doing the work safely next time.