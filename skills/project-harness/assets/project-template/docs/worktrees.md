# Branch and Worktree Management

Use this document when deciding whether work should stay in the current working tree, use a branch, or use a separate Git worktree. In single-conversation harness mode, worktrees are optional isolation tools, not a requirement to open a new conversation.

## Core Rule

- Branches are lightweight Git pointers.
- Worktrees are real local folders and can consume significant disk space, especially when they contain `node_modules`, build output, caches, or generated assets.
- The master/control conversation owns worktree policy, cleanup, integration, and merge order.
- Product and documentation conversations should normally use the main working tree.
- Feature, bugfix, backend, frontend, and experiment conversations may use separate worktrees when isolation is useful.
- Do not create worktrees by default for every task.

## Default Choice

Use the same working tree for:

- Product discussion and requirement clarification.
- Documentation-only updates.
- Small fixes that do not overlap with active feature work.
- Master/control review, merge, and changelog work.
- Ordinary single-conversation implementation that has clear scope and low conflict risk.

Use a separate worktree for:

- Parallel frontend and backend implementation.
- Large feature work.
- Risky refactors.
- Experiments and prototypes.
- Bugfixes with unclear root cause or broad code impact.
- Any task likely to conflict with another active conversation.

## Conversation Defaults

- Master/control: main working tree.
- Product/architecture: same working tree unless the user explicitly asks for isolated documentation work.
- Frontend: separate worktree for non-trivial feature work; same working tree for tiny UI fixes only when no parallel work conflicts.
- Backend: separate worktree for non-trivial API, schema, auth, or server changes.
- Bugfix: same working tree for small obvious fixes; separate worktree for complex debugging or risky fixes.
- Experiment: separate worktree.

## Before Creating a Worktree

The master/control conversation should check:

- Current branch and working tree status.
- Existing worktrees.
- Whether the task already has an active branch/worktree.
- Whether the task is small enough to stay in the current working tree.
- Whether the user wants to conserve disk space.

Do not create new worktrees automatically for product discussion, acceptance, documentation-only coordination, or ordinary single-conversation work.

## Naming

Use task-oriented branch names:

- `feature/fe-001-dashboard`
- `feature/be-001-api`
- `fix/bug-001-login`
- `experiment/editor-prototype`

Use clear worktree folder names that include the project name or task ID when possible.

## Cleanup

Master/control should periodically ask to audit branches and worktrees, especially after merges.

Cleanup flow:

1. List branches and worktrees.
2. Identify main working tree, active task worktrees, merged branches, stale branches, and abandoned experiments.
3. Report recommendations first.
4. Do not delete branches or worktree folders without explicit user approval.
5. After approval, remove only confirmed stale worktrees and branches.

## Copy-Ready Prompt

```text
Please use the latest project-harness worktree rules to inspect this project.

List current Git branches and worktrees, identify which ones are active, merged, stale, or safe to clean, and give me a cleanup recommendation first. Do not delete anything until I explicitly approve it.
```
