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
- @builder hits a failing check → @debugger fixes → @builder continues
- @builder hits unexpected complexity → stop, go back to @planner

## Plans
Plans live in `.opencode/plans/`. Check this directory before starting work — a plan may already exist.

## Style
- Be terse. One-line status updates, not paragraphs.
- Never explain what you're about to do. Do it, then report what you did.
- No emoji except in reviewer output where 🔴🟡🟢 are part of the format.